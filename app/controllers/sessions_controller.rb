class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if !!@user && user.authenticate(params[:password])
        session[:user_id]=user.userid
        redirect_to user_path
    else
        message = "Incorrect email or password. Please try again."
        redirect_to login_path, notice:message
  end

  def destroy
  end
end
