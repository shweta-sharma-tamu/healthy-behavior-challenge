# frozen_string_literal: true

class PassswordMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.passsword_mailer.reset.subject
  #
  def reset
    @token = params[:user].signed_id(purpose: 'password_reset', expires_in: 360.minutes)

    mail to: params[:user].email
  end
end
