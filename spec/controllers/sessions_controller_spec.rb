require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do
    context 'when user is logged in' do
      let(:user) { create(:user) }  # Assuming you have a User factory set up

      before do
        session[:user_id] = user.id
      end

      it 'redirects to the user profile' do
        get :new
        expect(response).to redirect_to(user_path(session[:user_id]))
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns a new user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

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

  describe 'GET #destroy' do
    context 'with valid credentials' do
     let(:user_params) { { email: 'Admin@gmail.com', password: 'Admin@123' } }

      it 'logs out the user' do
        get :destroy
        allow(controller).to receive(:destroy).and_return(true)
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
