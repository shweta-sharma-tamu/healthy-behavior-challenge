require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid credentials' do
     let(:user_params) { { email: 'Admin@gmail.com', password: 'Admin@123' } }

      it 'logs in the user' do
        post :create, params: { email: 'Admin@gmail.com', password: 'Admin@123' }
        allow(controller).to receive(:create).and_return(true)
        expect(session[:user_id]).to be_truthy
      end

      it 'redirects to the home page' do
        post :create, params: { email: 'Admin@gmail.com', password: 'Admin@123' }
        allow(controller).to receive(:create).and_return(true)
        expect(response).to redirect_to(user_path(session[:user_id]))
      end
    end

    context 'with invalid credentials' do
      it 'redirects to the login page' do
        post :create, params: { email: 'invalid@example.com', password: 'wrongpassword' }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
