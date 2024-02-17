# frozen_string_literal: true

class InstructorReferralMailer < ApplicationMailer
  def refer
    @referral = params[:referral]
    mail to: params[:email], subject: "Here's your referral link"
  end
end
