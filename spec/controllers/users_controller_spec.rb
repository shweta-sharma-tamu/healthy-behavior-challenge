require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }

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
    let(:valid_params) { { user: { name: 'John Doe', email: 'john@example.com', password: 'password' } } }
    let(:invalid_params) { { user: { name: '', email: '', password: '' } } }

    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end
    end
  end
end
