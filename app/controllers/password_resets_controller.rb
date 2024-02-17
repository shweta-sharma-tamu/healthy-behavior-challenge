# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    if params[:email].empty?
      redirect_to password_reset_path, alert: "Email can't be blank."
      return
    elsif !valid_email?(params[:email])
      redirect_to password_reset_path, alert: 'Invalid email format. Please enter a valid email address.'
      return
    end
    @user = User.find_by(email: params[:email])

    PassswordMailer.with(user: @user).reset.deliver_now if @user.present?
    redirect_to root_path, notice: 'If an account with email was found, we have sent a link to reset your password.'
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    Rails.logger.error('InvalidSignature exception raised.')
    redirect_to root_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if @user.update(password_params)
      redirect_to root_path, notice: 'Your password was reset successfully. Please sign in.'
    else
      render :edit, status: :bad_request
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_email?(email)
    # Regular expression for matching email addresses
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    # Use the match? method to check if the string matches the email regex
    email.match?(email_regex)
  end
end
