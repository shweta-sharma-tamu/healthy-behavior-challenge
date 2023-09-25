require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { create(:user) } # Assuming you're using FactoryBot for creating users

  it 'sends a password reset email' do
    post :create, params: { email: user.email }
    expect(response).to redirect_to(root_path) # Adjust the path as needed
    expect(flash[:notice]).to eq('If an account with email was found, we have sent a link to reset your password.')
  end
end

RSpec.describe PasswordResetsController, type: :controller do
    let(:user) { create(:user) }
    let(:token) {  user.signed_id(purpose: "password_reset", expires_in: 360.minutes) }
  
    it 'resets the password' do
      patch :update, params: { token: token, user: { password: 'new_password', password_confirmation: 'new_password' } }
      expect(response).to redirect_to(root_path) # Adjust the path as needed
      expect(flash[:notice]).to eq('Your password was reset successfully. Please sign in.')
    end
  end
  
RSpec.describe PasswordResetsController, type: :controller do
  it 'redirects with an error message for an invalid token' do
    get :edit, params: { token: 'invalid_token' } 
    expect(response).to redirect_to(root_path) # Adjust the path as needed
    expect(flash[:alert]).to eq('Your token has expired. Please try again.')
  end
end
  