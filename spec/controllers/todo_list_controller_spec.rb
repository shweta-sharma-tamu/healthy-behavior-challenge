require 'rails_helper'

RSpec.describe TodoListController, type: :controller do
  before do
    #@user = create(:user) # Use your FactoryBot or create a user
    @user2 = User.create!(email: 'instructor2@example.com', password: 'abcdef',user_type: "Instructor")
    @instructor = Instructor.create(user_id: @user2.id, first_name: "instructor2", last_name: "instructor2_last_name")

    @user = User.create!(email: 'traineetest2@example.com', password: 'asdf',user_type: "trainee")
    @trainee = Trainee.create(full_name: 'trainee2', height: 165, weight: 85, user_id: @user.id)

    @challenge2 = Challenge.create(name: 'challenge2', startDate: Date.today, endDate: Date.today, instructor_id: @instructor.id)
    @challengetrainee = ChallengeTrainee.create(trainee_id: @trainee.id, challenge_id: @challenge2.id)
    @task1 = Task.create(taskName: "exercise")
    @task2 = Task.create(taskName: "steps")
    @todolisttask = TodolistTask.create(task_id: @task1.id, status: "not_completed", trainee_id: @trainee.id, challenge_id: @challenge2.id, date: Date.today)
    @todolisttask = TodolistTask.create(task_id: @task2.id, status: "not_completed", trainee_id: @trainee.id, challenge_id: @challenge2.id, date: Date.today)
    
    session[:user_id] = @user.id
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show
      expect(response).to render_template(:show)
    end
  end

  describe 'PATCH #update' do
    it 'updates tasks' do
    end
  end
end
