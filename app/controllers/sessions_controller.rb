class SessionsController < ApplicationController

  def new
    if !!user_signed_in?
          redirect_to user_path(session[:user_id])
    end
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])

    if !!@user && @user.authenticate(params[:password])
        session[:user_id]=@user.id
        flash[:notice] = "Successfully signed in"
        redirect_to user_path(session[:user_id])
    else
        message = params[:email]
        message = "Incorrect email or password. Please try again."
        redirect_to new_session_url, notice: message
  end

  def destroy
  end
end
end