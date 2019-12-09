class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # debugger
  end
  
  def new
    # /users/newページのフォームを作成するために、仮のuserをつくる。
    @user = User.new
  end
  
  def create
    # フォームで入力された情報がparamsに入ってやってくる。(submit時])
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # => redirect_to user_url(@user)
    else
      render "new"
    end
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
