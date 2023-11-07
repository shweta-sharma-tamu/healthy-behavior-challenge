class TraineesController < ApplicationController
  before_action :require_user

    def show_challenges
        user_id = session[:user_id]
        @trainee = Trainee.find_by(user_id: user_id)
        @challenge_ids = ChallengeTrainee.where(trainee_id: @trainee.id).pluck(:challenge_id)
        @curr_challenges = Challenge.where('"id" in ( ? ) AND "startDate" <= ? AND "endDate" >= ?', @challenge_ids, Date.today, Date.today).order('"endDate" ASC')
        @past_challenges = Challenge.where('"id" in ( ? ) AND "endDate" <= ?', @challenge_ids, Date.today).order('"endDate" ASC')
    end

    private

    def require_user
        unless user_signed_in? 
          flash[:alert] = "You must be signed in to access this page."
          redirect_to login_path
        end
      end
  
end