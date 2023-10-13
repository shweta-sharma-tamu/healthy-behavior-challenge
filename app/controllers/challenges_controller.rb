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

      if @instructor
        begin
          @challenge = Challenge.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          flash[:alert] = "Challenge not found."
          redirect_to challenges_path
        end
      else
        flash[:notice] = "You are not an instructor."
        redirect_to root_path
      end
    end
  
    def add_trainees
      @challenge = Challenge.find(params[:id])
      if @challenge.startDate <= Date.today
        flash.now[:alert] = "Challenge has already started. You cannot add trainees."
        @trainees = []
      else
        @challenge_trainees = ChallengeTrainee.where(challenge_id: params[:id])
        trainee_ids = @challenge_trainees.pluck(:trainee_id)
        @trainees = Trainee.where.not(id: trainee_ids)
      end
    end

    def update_trainees
      @challenge = Challenge.find(params[:id])
      if @challenge.trainees << Trainee.where(id: params[:trainee_ids])
        flash.now[:notice] = "Trainees were successfully added to the challenge."
      else
        flash.now[:alert] = "Something went wrong. Challenge was not updated."
      end
      @challenge_trainees = ChallengeTrainee.where(challenge_id: params[:id])
      trainee_ids = @challenge_trainees.pluck(:trainee_id)
      @trainees = Trainee.where.not(id: trainee_ids)
      render 'add_trainees'
    end
  
    private
  
    def challenge_params
      params.require(:challenge).permit(:name, :startDate, :endDate, tasks_attributes: [:id, :taskName, :_destroy])
    end
  end
  