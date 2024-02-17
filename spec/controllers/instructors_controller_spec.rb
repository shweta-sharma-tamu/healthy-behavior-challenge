# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstructorsController, type: :controller do
  before :each do
    User.create(email: 'instructor@example.com', password: 'password', user_type: 'Instructor')
    @token = SecureRandom.uuid
    @user = User.find_by(email: 'instructor@example.com')
    # Create a new referral associated with the user
    @referral = @user.instructor_referrals.create(email: 'example@example.com', token: @token, is_used: false,
                                                  expires: Date.today + 7.days)
    @referral_link = "#{ENV['ROOT_URL']}#{instructor_signup_path(token: @token)}"
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { token: @token }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    let(:instructor) { create(:instructor, user: @user) }
    let(:challenge) { create(:challenge, instructor:) }
    it 'assigns the correct challenges' do
      session[:user_id] = @user.id
      get :show, params: { instructor_id: instructor.id }
      expect(assigns(:challenges)).to eq([challenge])
    end

    it 'paginates the challenges' do
      session[:user_id] = @user.id
      create_list(:challenge, 10, instructor:) # Create 10 challenges for the instructor

      get :show, params: { instructor_id: instructor.id, page: 2 }
      expect(assigns(:challenges).count).to eq(10) # 10 challenges per page
    end

    it 'sets @is_instructor to true for a valid instructor' do
      session[:user_id] = @user.id
      get :show, params: { instructor_id: instructor.id }
      expect(assigns(:is_instructor)).to be_truthy
    end

    it 'renders the show template' do
      session[:user_id] = @user.id
      get :show, params: { instructor_id: instructor.id }
      expect(response).to render_template('show')
    end
    it 'redirects to root path if not signed in' do
      get :show, params: { instructor_id: instructor.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #show_prev_challenges' do
    let(:instructor) { create(:instructor, user: @user) }
    let(:challenge) do
      create(:challenge, startDate: Date.today - 2.week, endDate: Date.today - 1.week, instructor:)
    end

    it 'assigns the correct challenges' do
      session[:user_id] = @user.id
      get :show_prev_challenges, params: { instructor_id: instructor.id }
      expect(assigns(:challenges)).to eq([challenge])
    end

    it 'paginates the challenges' do
      session[:user_id] = @user.id
      create_list(:challenge, 10, startDate: Date.today - 2.week, endDate: Date.today - 1.week, instructor:) # Create 10 challenges for the instructor

      get :show_prev_challenges, params: { instructor_id: instructor.id, page: 2 }
      expect(assigns(:challenges).count).to eq(10) # 10 challenges per page
    end

    it 'renders the show template' do
      session[:user_id] = @user.id
      get :show_prev_challenges, params: { instructor_id: instructor.id }
      expect(response).to render_template('show_prev_challenges')
    end

    it 'redirects to root path if not signed in' do
      get :show_prev_challenges, params: { instructor_id: instructor.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #show_future_challenges' do
    let(:instructor) { create(:instructor, user: @user) }
    let(:challenge) do
      create(:challenge, startDate: Date.today + 2.week, endDate: Date.today + 3.week, instructor:)
    end

    it 'assigns the correct challenges' do
      session[:user_id] = @user.id
      get :show_future_challenges, params: { instructor_id: instructor.id }
      expect(assigns(:challenges)).to eq([challenge])
    end

    it 'paginates the challenges' do
      session[:user_id] = @user.id
      create_list(:challenge, 10, startDate: Date.today + 2.week, endDate: Date.today + 3.week, instructor:) # Create 10 challenges for the instructor
      get :show_future_challenges, params: { instructor_id: instructor.id, page: 2 }
      expect(assigns(:challenges).count).to eq(10) # 10 challenges per page
    end

    it 'renders the show future template' do
      session[:user_id] = @user.id
      get :show_future_challenges, params: { instructor_id: instructor.id }
      expect(response).to render_template('show_future_challenges')
    end

    it 'redirects to root path if not signed in' do
      get :show_future_challenges, params: { instructor_id: instructor.id }
      expect(response).to redirect_to(root_path)
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

        expect(response).to redirect_to(instructor_signup_path(token: @token).to_s)
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
