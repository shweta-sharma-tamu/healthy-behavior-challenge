# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to user_path(session[:user_id]) unless user_signed_in?.nil?
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'You have successfully signed in'
      redirect_to user_path(session[:user_id])
    else
      params[:email]
      message = 'Incorrect email or password. Please try again.'
      redirect_to new_session_url, alert: message
    end
  end

  def destroy
    session[:user_id] = nil # Clear the user's session
    message = 'You have been signed out.'
    redirect_to new_session_url, notice: message
  end
end
