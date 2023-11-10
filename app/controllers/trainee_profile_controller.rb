class TraineeProfileController < ApplicationController
    def show
      @trainee = Trainee.find_by(user_id: session[:user_id])
      unless @trainee
        redirect_to root_path
        return
      end
    end
  end
  