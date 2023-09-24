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
end
