# spec/controllers/trainees_controller_spec.rb
require 'rails_helper'

RSpec.describe TraineesController, type: :controller do
  describe 'GET #show_challenges' do
    context 'when user is signed in' do
      it 'assigns the trainee and challenge data' do
        user = create(:user)
        trainee = create(:trainee, user: user)
        challenge1 = create(:challenge, start_date: Date.today - 1, end_date: Date.today + 1)
        challenge2 = create(:challenge, start_date: Date.today - 2, end_date: Date.today - 1)
        ChallengeTrainee.create(trainee: trainee, challenge: challenge1)
        ChallengeTrainee.create(trainee: trainee, challenge: challenge2)

        session[:user_id] = user.id
        get :show_challenges

        expect(assigns(:trainee)).to eq(trainee)
        expect(assigns(:curr_challenges)).to contain_exactly(challenge1)
        expect(assigns(:past_challenges)).to contain_exactly(challenge2)
      end

      it 'renders the show_challenges template' do
        user = create(:user)
        trainee = create(:trainee, user: user)
        session[:user_id] = user.id

        get :show_challenges

        expect(response).to render_template('show_challenges')
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the login page with an alert' do
        get :show_challenges

        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You must be signed in to access this page.")
      end
    end
  end
end
