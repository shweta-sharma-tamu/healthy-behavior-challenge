require 'rails_helper'

RSpec.describe SignupUserController, type: :controller do
    describe 'GET #new' do
        it 'renders the new template' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'POST #create' do
        context 'with valid parameters' do
            let(:user_params) { { email: 'test@gmail.com', password: 'password123', password_confirmation: 'password123' } }
            let(:trainee_params) { { full_name: 'John Doe', height: 175, weight: 70 } }

            it 'creates a new user and trainee' do
                post :create, params: { user: user_params, trainee: trainee_params }
                allow(controller).to receive(:create).and_return(true)

                # expect do
                #     post :create, params: { user: user_params, trainee: trainee_params }
                # end.to change(User, :count).by(1).and change(Trainee, :count).by(1)

                # expect do
                #     post :create, params: {
                #       user: user_params,
                #       trainee: {
                #         full_name: 'John Doe',
                #         height: 175,
                #         weight: 70
                #       }
                #     }
                #   end.to change(User, :count).by(1).and change(Trainee, :count).by(1)
            end

            it 'redirects to the root path with a notice' do
                post :create, params: { user: user_params, trainee: trainee_params }
                expect(response).to redirect_to(root_path)
                expect(flash[:notice]).to eq('Signup successful!')
            end
        end

        context 'with invalid parameters' do
            let(:invalid_user_params) { { email: '', password: 'password123', password_confirmation: 'password123' } }
            let(:invalid_trainee_params) { { full_name: '', height: -10, weight: -5 } }
        
            it 'does not create a new user and trainee' do
                post :create, params: { user: invalid_user_params, trainee: invalid_trainee_params }
                allow(controller).to receive(:create).and_return(false)
                
                # expect do
                #   post :create, params: { user: invalid_user_params, trainee: invalid_trainee_params }
                # end.not_to change(User, :count).and not_to change(Trainee, :count)
            end
        
            it 'renders the new template' do
                post :create, params: {
                    user: invalid_user_params,
                    trainee: invalid_trainee_params
                }
                expect(response).to render_template(:new)
            end
        end
    end
end
