require 'rails_helper'

RSpec.describe TraineeSignupController, type: :controller do
    describe 'GET #new' do
        it 'renders the new template' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'POST #create' do
        context 'with valid parameters' do
            let(:user_params) { { email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123', full_name: 'John Doe', height: 175, weight: 70 } }

            it 'creates a new user and trainee' do
                expect do
                    post :create, params: { user: user_params }
                end.to change(User, :count).by(1).and change(Trainee, :count).by(1)
            end

            it 'redirects to the root path with a notice' do
                post :create, params: { user: user_params }
                expect(response).to redirect_to(login_path)
                expect(flash[:notice]).to eq('Signup successful!')
            end
        end

        context 'with invalid parameters' do
            let(:invalid_user_params) { { email: '', password: 'password123', password_confirmation: 'password123', full_name: '', height: -10, weight: -5 } }
        
            it 'does not create a new user and trainee' do
                expect do
                  post :create, params: { user: invalid_user_params }
                end.to change(User, :count).by(0).and change(Trainee, :count).by(0)
            end
        
            it 'renders the new template' do
                post :create, params: { user: invalid_user_params }
                expect(response).to render_template(:new)
            end
        end
    end
end
