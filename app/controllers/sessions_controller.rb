class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      reset_session      # ログインの直前に必ずこれを書くこと
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
      # redirect_to vs. render
      # GET /users/1 => show template
      #    render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
