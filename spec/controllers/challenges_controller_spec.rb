require 'rails_helper'

RSpec.describe ChallengesController, type: :controller do
  before(:each) do
    @user = User.create(email: 'instructor@example.com', password: 'password', user_type: 'Instructor')

    # Create an instructor instance
    @instructor = Instructor.create(user: @user, first_name: 'John', last_name: 'Doe')

    @challenge = Challenge.create(name: 'Test Challenge', startDate: Date.tomorrow, endDate: Date.tomorrow + 1) 
    @challenge1 = Challenge.create(name: 'Test Challenge1', startDate: Date.yesterday, endDate: Date.tomorrow + 1)
    @trainee1 = Trainee.create(full_name: 'Test Trainee1', height: 1.75, weight: 70.0, id:1) 
    @trainee2 = Trainee.create(full_name: 'Test Trainee2', height: 1.80, weight: 75.0, id:2) 
  
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
      get :add_trainees, params: { id: @challenge.id }
      expect(assigns(:challenge)).to eq(@challenge)
    end

  end

  describe 'POST #update_trainees' do

    it 'assigns @challenge if the challenge has not started' do
      get :add_trainees, params: { id: @challenge.id }
      expect(assigns(:challenge)).to eq(@challenge)
      post :update_trainees, params: {id: @challenge.id, trainee_ids: [@trainee1.id,@trainee2.id]}
      expect(flash.now[:notice]).to eq('Trainees were successfully added to the challenge.')
    end
  end


  private

  def valid_params
    { name: 'New Challenge', startDate: '2023-10-15', endDate: '2023-10-30', tasks_attributes: { '0' => { taskName: 'Task 1' }, '1' => { taskName: 'Task 1' } } }
  end
end
