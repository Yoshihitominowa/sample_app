class UsersController < ApplicationController

  def show
    #@user = User.first
    @user = User.find(params[:id])

  end


  def new
    @user = User.new
    # => GET app/views/usrs/new.html.erb
  end
  
  def create
     @user = User.new(user_params)   # 実装は終わっていないことに注意!
    if @user.save
        reset_session
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      # 保存の成功をここで扱う。
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
  # Strong Parameters
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end


