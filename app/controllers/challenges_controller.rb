 # app/controllers/challenges_controller.rb
class ChallengesController < ApplicationController
  include ChallengesHelper

    def new
      @challenge = Challenge.new
      @instructor = Instructor.find_by(user_id: session[:user_id])
      Rails.logger.debug(@instructor)
      unless @instructor
        flash[:alert] = "You are not an instructor."
        redirect_to root_path
        return
      end
      @is_instructor = true
    end
  
    def create
      @challenge = Challenge.new(challenge_params)
      @instructor = Instructor.find_by(user_id: session[:user_id])
      @challenge.instructor = @instructor
     
      if Challenge.find_by(name: @challenge.name)
        flash[:alert] = "A challenge with the same name already exists."
        redirect_to new_challenge_path
        return
      end

      if params[:challenge][:startDate]>params[:challenge][:endDate]
        flash[:alert] = "start date is greater than end date"
        redirect_to new_challenge_path
        return
      end

      existing_tasks = []

      if params[:challenge][:tasks_attributes].present?
      params[:challenge][:tasks_attributes].each do |task_attributes|
        task_name = task_attributes[1][:taskName]
        # Check if a task with the same name already exists
        existing_task = Task.find_by(taskName: task_name)
    
        if existing_task
          existing_tasks << existing_task
        else
          new_task = Task.new(taskName: task_name)
          existing_tasks << new_task
        end
      end
    end
    
      # Replace the task attributes with the existing tasks
      @challenge.tasks = existing_tasks


      if @challenge.save
        flash[:notice] = "Challenge successfully created."
        redirect_to new_challenge_path
        return
      end
    end

    # Other actions...
    def show
      @instructor = Instructor.find_by(user_id: session[:user_id])
      Rails.logger.debug(@instructor)
      unless @instructor
        flash[:notice] = "You are not an instructor."
        redirect_to root_path
        return
      end

      begin
        @challenge = Challenge.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Challenge not found."
        redirect_to challenges_path
      end
    end
  
    private
  
    def challenge_params
      params.require(:challenge).permit(:name, :startDate, :endDate, tasks_attributes: [:id, :taskName, :_destroy])
    end
  end
  