require 'rails_helper'

RSpec.describe InstructorController, type: :controller do

  before :each do
    User.create(email: 'instructor@example.com', password: 'password',user_type:"Instructor")
    @token = SecureRandom.uuid
    @user = User.find_by(email: "instructor@example.com")
    # Create a new referral associated with the user
    @referral = @user.instructor_referrals.create(email: "example@example.com", token: @token, is_used: false,expires: Date.today+7.days)
    @referral_link = "#{ENV['ROOT_URL']}#{instructor_signup_path(token: @token)}"
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { token: @token }
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
          }, token: @token
        }

        expect(response).to redirect_to(user_path(assigns(:user).id))
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
          }, token: @token
        }

        expect(response).to render_template(:new)
      end

      it 'does not create a new instructor and user with password mismatch' do
        post :create, params: {
          user: {
            email: 'test@example.com',
            password: 'password',
            confirm_password: 'different_password',
            first_name: 'John',
            last_name: 'Doe'
          }, token: @token
        }

        expect(response).to redirect_to("#{instructor_signup_path(token: @token)}")
      end

      it 'does not create a new instructor and user with invalid email' do
        post :create, params: {
          user: {
            email: 'invalid_email',
            password: 'password',
            confirm_password: 'password',
            first_name: 'John',
            last_name: 'Doe'
          }, token: @token
        }

        expect(response).to render_template(:new)
      end
    end
  end
end
