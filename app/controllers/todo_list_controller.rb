class TodoListController < ApplicationController
    def new 
        @user = User.new
        @trainee = Trainee.new
    end

    def show
        @user = User.find(session[:user_id])
        puts @user
        puts @user.id
        @is_instructor = @user.user_type == "instructor"
        if @is_instructor
            @instructor = Instructor.find_by(user_id: @user.id)
            if @instructor
                redirect_to instructor_path(@instructor)
            else
                render plain: 'Instructor not found', status: :not_found
            end
        else
            trainee = Trainee.find_by(user_id: @user.id)
        end
        trainee_id = trainee.id
        puts trainee_id
        puts trainee
        """
        trainee_challenge = ChallengeTrainee.find_by(trainee_id: trainee_id)
        trainee_challenge_id = trainee_challenge.challenge_id
        puts trainee_challenge_id
        current_date = Date.today
        @todo_list = TodolistTask.where(trainee_id: trainee_id, challenge_id: trainee_challenge_id, date: current_date).pluck(:task_id, :status)
        @date = current_date
        """
        @challenge_to_do_lists = []
        @trainee_challenges = ChallengeTrainee.where(trainee_id: trainee_id)
        @trainee_challenges.each do |trainee_challenge|
            trainee_challenge_id = trainee_challenge.challenge_id
            @challenge = Challenge.find_by(id: trainee_challenge_id)
            puts trainee_challenge_id
            current_date = Date.today
            @todo_list = TodolistTask.where(trainee_id: trainee_id, challenge_id: trainee_challenge_id, date: current_date).pluck(:task_id, :status)
            @date = current_date
            @challenge_to_do_lists << { challenge: @challenge, todo_list: @todo_list }
        end
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

    def movie_params
        params.require(:todo).permit(:user_id, :task_name, :status, :trainee_id, :challenge_id, :date, :tasks)
    end
end
