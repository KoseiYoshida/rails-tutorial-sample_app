class SessionsController < ApplicationController
  def new
  end
  
  def create
    target_email = params[:session][:email].downcase
    target_password = params[:session][:password]
    user = User.find_by(email:target_email)
    if user && user.authenticate(target_password)
      log_in user
      # same - redirect_to user_url(user)
      redirect_to user
    else
      flash.now[:danger] = "invalid email/password conbination"
      render "new"
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
