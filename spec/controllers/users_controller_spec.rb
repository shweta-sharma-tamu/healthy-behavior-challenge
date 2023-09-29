require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { User.first || create(:user) }

    it 'assigns the correct user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { user: { email: 'valid@example.com', password: 'password', user_type: 'trainee' } }
      end

      it 'creates a new user' do
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end

      it 'sets the session[:user_id] to the new user id' do
        post :create, params: valid_params
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { user: { email: '', password: 'password', user_type: 'regular' } }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_params
        end.to change(User, :count).by(0)
      end

      it 'renders the sessions/new template on failure' do
        post :create, params: invalid_params
        expect(response).to render_template('sessions/new')
      end
    end
  end
end
