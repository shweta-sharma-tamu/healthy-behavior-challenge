class TodoListController < ApplicationController
    before_action :require_user


    
    def new 
        @user = User.new
        @trainee = Trainee.new
    end

    def show
        @user = User.find(session[:user_id])
        puts @user
        puts @user.id
        trainee = Trainee.find_by(user_id: @user.id)
        trainee_id = trainee.id
        puts trainee_id
        puts trainee
        trainee_challenge = ChallengeTrainee.find_by(trainee_id: trainee_id)
        trainee_challenge_id = trainee_challenge.challenge_id
        puts trainee_challenge_id
        current_date = Date.today
        @todo_list = TodolistTask.where(trainee_id: trainee_id, challenge_id: trainee_challenge_id, date: current_date).pluck(:task_id, :status)
        @date = current_date
    end

    def update
        @user = User.find(session[:user_id])
        trainee = Trainee.find_by(user_id: @user.id)
        trainee_id = trainee.id
        trainee_challenge_id = ChallengeTrainee.find_by(trainee_id: trainee_id).challenge_id
        current_date = Date.today
        task_params = params[:tasks] || {} 
        task_params.each do |task_id, status|
            TodolistTask.find_by(id: task_id, date: @date).update(status: status)
        end
        @todo_list = TodolistTask.where(trainee_id: trainee_id, challenge_id: trainee_challenge_id, date: current_date).pluck(:task_id, :status)
        @date = current_date
        redirect_to todo_list_path, notice: 'Tasks have been updated.'
    end

    private

    def require_user
      unless user_signed_in? 
        flash[:alert] = "You must be signed in to access this page."
        redirect_to login_path
      end
    end
    
    def movie_params
        params.require(:todo).permit(:user_id, :task_name, :status, :trainee_id, :challenge_id, :date, :tasks)
    end
end
