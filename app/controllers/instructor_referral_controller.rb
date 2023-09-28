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
            link = "#{ENV['ROOT_URL']}/signup/#{@token}"
            InstructorReferralMailer.with(referral: @referral,email: params[:email],link: link).refer.deliver_now
            flash.now[:notice] = "Copy this link: <a href='#{link}'>#{link}</a>"
        end
        render action: "index"
    end

    # private

    def user_params
        params.require(:user).permit(:email, :password, :user_type)
    end
end
