class InstructorReferralMailer < ApplicationMailer
    def refer
        @referral = params[:referral]
        @link = params[:link]
        mail to: params[:email], subject: "Here's your referral link"
    end
end
