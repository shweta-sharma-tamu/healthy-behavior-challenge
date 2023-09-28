require 'securerandom'

class InstructorReferralController < ApplicationController
    def index
        # Add any logic needed for the instructor referral page here

    end

    def create
        @user = User.find(session[:user_id])
        @token = SecureRandom.uuid
        @referral = @user.instructor_referrals.create(email: params[:email],token: @token, expires: Date.today+7.days)
        errors = @referral.errors.full_messages
        p errors
        if errors.length != 0
            flash.now[:alert] = "Error: "+ errors.join(",")
        else
            @referral.save
            InstructorReferralMailer.with(referral: @referral,email: params[:email],is_used: false).refer.deliver_now
            flash.now[:notice] = "Copy this link: #{ENV['ROOT_URL']}#{instructor_signup_path(token: @referral.token)}"
        end
        render action: "index"
    end

    # private

    def user_params
        params.require(:user).permit(:email, :password, :user_type)
    end
end
