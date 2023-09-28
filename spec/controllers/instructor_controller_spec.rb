require 'rails_helper'

RSpec.describe InstructorController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new instructor and user' do
        post :create, params: {
          user: {
            email: 'test@example.com',
            password: 'password',
            confirm_password: 'password',
            first_name: 'John',
            last_name: 'Doe'
          }
        }

        expect(response).to redirect_to(user_path(assigns(:user).id))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new instructor and user' do
        post :create, params: {
          user: {
            email: '',
            password: 'password',
            confirm_password: 'password',
            first_name: 'John',
            last_name: 'Doe'
          }
        }

        expect(response).to redirect_to(instructor_signup_path)
        expect(flash[:error]).to be_present
        #expect(flash[:error]).to "Incorrect email or password. Please try again."
      end

      it 'does not create a new instructor and user with password mismatch' do
        post :create, params: {
          user: {
            email: 'test@example.com',
            password: 'password',
            confirm_password: 'different_password',
            first_name: 'John',
            last_name: 'Doe'
          }
        }

        expect(response).to redirect_to(instructor_signup_path)
        expect(flash[:error]).to be_present
      end

      it 'does not create a new instructor and user with invalid email' do
        post :create, params: {
          user: {
            email: 'invalid_email',
            password: 'password',
            confirm_password: 'password',
            first_name: 'John',
            last_name: 'Doe'
          }
        }

        expect(response).to render_template(:new)
        expect(flash[:error]).to be_present
      end
    end
  end
end
