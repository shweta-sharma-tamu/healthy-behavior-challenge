require 'rails_helper'
require 'spec_helper'

RSpec.describe ChallengesController, type: :controller do

  after(:all) do
    ChallengeTrainee.destroy_all
    ChallengeGenericlist.destroy_all
    Challenge.destroy_all
    Trainee.destroy_all
  end

  before(:each) do
    @user = User.create(email: 'instructor@example.com', password: 'password', user_type: 'Instructor')

    @user2 = User.create(email: 'trainee@example.com', password: 'password', user_type: 'Trainee')

    # Create an instructor instance
    @instructor = Instructor.create(user: @user, first_name: 'John', last_name: 'Doe')
  

    @trainee = Trainee.create(user: @user, full_name: 'John Doe', height: 160, weight: 65)
  end

  describe 'GET #new' do
    it 'assigns a new challenge' do
      get :new
      expect(assigns(:challenge)).to be_a_new(Challenge)
    end

    it 'redirects to root_path if the user is not an instructor' do
      get :new
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You are not an instructor.')
    end

    it 'assigns @is_instructor to true if the user is an instructor' do
      session[:user_id] = @instructor.user_id
      get :new
      expect(assigns(:is_instructor)).to eq(true)
    end
  end

  describe 'POST #create' do
    context 'when the user is an instructor' do
      it 'creates a new challenge with valid params' do
        session[:user_id] = @instructor.user_id
        post :create, params: { challenge: valid_params }
        expect(response).to redirect_to(new_challenge_path)
        expect(flash[:notice]).to eq('Challenge successfully created.')
      end

      it 'redirects to new_challenge_path with alert if the challenge name already exists' do
        session[:user_id] = @instructor.user_id
        post :create, params: { challenge: valid_params }
        post :create, params: { challenge: valid_params }
        expect(response).to redirect_to(new_challenge_path)
        expect(flash[:alert]).to eq('A challenge with the same name already exists.')
      end
    end

      it 'sets a flash message and redirects to the new challenge page' do
        session[:user_id] = @instructor.user_id

        # Prepare invalid challenge data with start date > end date
        challenge_params = {
          challenge: {
            name: 'Test Challenge',
            startDate: '2023-10-10',
            endDate: '2023-10-01'  # Start date is greater than end date
          }
        }

        post :create, params: challenge_params

        # Expect flash message and redirection
        expect(flash[:alert]).to eq('start date is greater than end date')
        expect(response).to redirect_to(new_challenge_path)
      end
  end

  describe 'GET #add_trainees' do

    it 'assigns @challenge if the challenge has not started' do
      session[:user_id] = @instructor.user_id
      @challenge = Challenge.create(name: 'Test Challenge', startDate: Date.tomorrow, endDate: Date.tomorrow + 1)
      @challenge.instructor = @instructor
      @challenge.save
      get :add_trainees, params: { id: @challenge.id }
      expect(assigns(:challenge)).to eq(@challenge)
    end

  end

  describe 'POST #update_trainees' do

    it 'assigns @challenge if the challenge has not started' do
      session[:user_id] = @instructor.user_id
      @challenge = Challenge.create(name: 'Test Challenge', startDate: Date.tomorrow, endDate: Date.tomorrow + 1)
      @challenge.instructor = @instructor
      @challenge.save
      @trainee1 = Trainee.create(full_name: 'Trainee 1', height:1.5, weight: 1.5)
      @trainee2 = Trainee.create(full_name: 'Trainee 2', height:1.5, weight: 1.5)
      @trainee1.save
      @trainee2.save
      
      get :add_trainees, params: { id: @challenge.id }
      expect(assigns(:challenge)).to eq(@challenge)
      post :update_trainees, params: {id: @challenge.id, trainee_ids: [@trainee1.id, @trainee2.id]}
      expect(flash.now[:notice]).to eq('Trainees were successfully added to the challenge.')
    end
  end


  describe 'GET #show' do
    context 'when the user is an instructor' do
      it 'renders the show template' do
        session[:user_id] = @instructor.user_id
        @challenge = Challenge.create(name: 'Example Challenge', startDate: Date.today, endDate: Date.tomorrow)
        @challenge.instructor = @instructor
        @challenge.save

        get :show, params: { id: @challenge.id }
        expect(response).to render_template(:show)
      end

      it 'assigns the requested challenge' do
        session[:user_id] = @instructor.user_id
        @challenge = Challenge.create(name: 'Example Challenge', startDate: Date.today, endDate: Date.tomorrow)
        @challenge.instructor = @instructor
        @challenge.save

        get :show, params: { id: @challenge.id }
        expect(assigns(:challenge)).to eq(@challenge)
      end
    end
  end
  
  describe 'list trainees for a challenge' do
    it 'displays trainees for a challenge' do
      session[:user_id] = @instructor.user_id
      @challenge = Challenge.create!(name: 'ex chall', startDate: '2023-10-15', endDate: '2023-10-30', instructor: @instructor, tasks_attributes: {
        '0' => { taskName: 'Task 1' },
        '1' => { taskName: 'Task 1' } 
      })
      user1 = User.create!(email: 'trainee22@example.com', password: 'abcdef', user_type: "Trainee")
      user2 = User.create!(email: 'trainee233@example.com', password: 'abcdef', user_type: "Trainee")
      user3 = User.create!(email: 'trainee322@example.com', password: 'abcdef', user_type: "Trainee")
      @trainee1 = Trainee.create!(full_name: "blah 1",user: user1,height:120,weight:120)
      @trainee2 = Trainee.create!(full_name: "blah 2",user: user2,height:120,weight:120)
      @trainee3 = Trainee.create!(full_name: "blah 3",user: user3,height:120,weight:120)
      @challenge.trainees << [@trainee1,@trainee2,@trainee3]
      get :trainees_list, params: {
            challenge_id: @challenge.id
        }, session: {
            user_id: @instructor.user_id
        }
      expect(response).to render_template(:trainees_list)
    end
  end
    describe 'GET task_progress' do
      it 'populates the required instance variables' do
        @challenge = Challenge.create!(name: 'ex chall', startDate: '2023-10-15', endDate: '2023-10-30', instructor: @instructor, tasks_attributes: {
          '0' => { taskName: 'Task 1' },
          '1' => { taskName: 'Task 1' } 
        })

        user1 = User.create!(email: 'trainee22dfas@example.com', password: 'abcdef', user_type: "Trainee")
        @trainee1 = Trainee.create!(full_name: "blah 1dsad",user: user1,height:120,weight:120)
        @task=Task.create!(taskName:"drink water")
        @challenge.trainees << @trainee1
        TodolistTask.create!(trainee_id: @trainee1.id, task_id: @task.id, challenge_id: @challenge.id, date: Date.today+1,status:"not_completed")
        get :task_progress, params: { trainee_id: @trainee1.id, id: @challenge } 
  
        expect(assigns(:dates_completed)).not_to be_nil
        expect(assigns(:counts_completed)).not_to be_nil
        expect(assigns(:dates_not_completed)).not_to be_nil
        expect(assigns(:counts_not_completed)).not_to be_nil
        expect(assigns(:counts_total)).not_to be_nil
        expect(assigns(:trainee)).not_to be_nil
        expect(assigns(:trainee_name)).not_to be_nil
      end
    end

  private

  def valid_params
    { name: 'New Challenge', startDate: '2023-10-15', endDate: '2023-10-30', tasks_attributes: { '0' => { taskName: 'Task 1' }, '1' => { taskName: 'Task 1' } } }
  end
end
