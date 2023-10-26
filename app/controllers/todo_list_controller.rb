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

        @challenge_to_do_lists = []
        @trainee_challenges = ChallengeTrainee.where(trainee_id: trainee_id)
        @trainee_challenges.each do |trainee_challenge|
            trainee_challenge_id = trainee_challenge.challenge_id
            @challenge = Challenge.find_by(id: trainee_challenge_id)
            puts trainee_challenge_id

            selected_date = params[:selected_date]
            if selected_date.blank?
                selected_date = params.dig(:user, :selected_date)
                if selected_date.blank?
                    current_date = Date.today
                else
                    current_date = Date.parse(selected_date)
                end
            else
                current_date = Date.parse(selected_date)
            end

            @todo_list = TodolistTask.where(trainee_id: trainee_id, challenge_id: trainee_challenge_id, date: current_date).pluck(:task_id, :status)
            @date = current_date
            @challenge_to_do_lists << { challenge: @challenge, todo_list: @todo_list }
        end
    end
      
    def mark_as_completed
        user_tasks = params[:user][:tasks]
        today_date = Date.today
        @user = User.find(session[:user_id])
        trainee = Trainee.find_by(user_id: @user.id)
        trainee_id = trainee.id

        user_tasks.each do |task_id, task_data|
            task_id = task_data[:task_id]
            challenge_id = task_data[:challenge_id]
            completed = task_data[:completed]
            current_date = task_data[:date]
            status = completed == '1' ? 'completed' : 'not_completed'

            @date = current_date
            task = TodolistTask.find_by(
                trainee_id: trainee_id,
                task_id: task_id,
                challenge_id: challenge_id,
                date: current_date
            )
        
            if task
                if status == "completed" 
                    #if current_date 
                  task.update(status: status)
                end
            end
        end
        
        redirect_to todo_list_path(selected_date: @date), notice: 'Tasks have been updated.'
    end   

    private
    def require_user
      unless user_signed_in? 
        flash[:alert] = "You must be signed in to access this page."
        redirect_to login_path
      end
    end

    def params_list
        params.require(:todo).permit(:user_id, :task_name, :status, :trainee_id, :challenge_id, :date, :tasks)
    end

    def params_listt
        params.require(:user).permit(:selected_date, tasks: %i[task_id challenge_id completed])
      end
end
