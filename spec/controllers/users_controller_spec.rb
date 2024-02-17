# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    context 'when trainee is logged in' do
      let(:user) { create(:user, email: 'trainee@gmail.com', user_type: 'Trainee') }
      let(:trainee) { create(:trainee, user:) }

      before do
        session[:user_id] = user.id
      end

      it 'assigns the correct user to @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the show template if user is trainee' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(todo_list_path)
      end

      it 'redirects to instructor path if user is instructor' do
        get :show, params: { id: user.id }
        # expect(response).to render_template(:show)
        expect(response).to redirect_to(todo_list_path)
      end
    end

    context 'when instructor is logged in' do
      let(:instructor_user) { create(:user, email: 'instructor2@gmail.com', user_type: 'Instructor') }

      before do
        session[:user_id] = instructor_user.id
      end

      it 'assigns the correct user to @user' do
        get :show, params: { id: instructor_user.id }
        expect(assigns(:user)).to eq(instructor_user)
      end

      it 'redirects to instructor path if user is instructor' do
        instructor = create(:instructor, user: instructor_user)
        session[:user_id] = instructor_user.id
        get :show, params: { id: instructor_user.id }
        expect(response).to redirect_to(instructor_path(instructor.id))
      end
    end
  end
end
