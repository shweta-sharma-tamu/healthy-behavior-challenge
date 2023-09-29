require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { User.first || create(:user) }

  it 'sends a password reset email' do
    post :create, params: { email: user.email }
    expect(response).to redirect_to(root_path) 
    expect(flash[:notice]).to eq('If an account with email was found, we have sent a link to reset your password.')
  end
end

RSpec.describe PasswordResetsController, type: :controller do
    let(:user) { User.first || create(:user) }
    let(:token) {  user.signed_id(purpose: "password_reset", expires_in: 360.minutes) }
  
    it 'resets the password' do
      patch :update, params: { token: token, user: { password: 'new_password', password_confirmation: 'new_password' } }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Your password was reset successfully. Please sign in.')
    end
  end

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { User.first || create(:user) }
  let(:token) {  user.signed_id(purpose: "password_reset", expires_in: 360.minutes) }

  it 'throws error for password is not matching with password confirmation' do
    patch :update, params: { token: token, user: { password: 'new_password', password_confirmation: 'new_password1' } }
    expect(response).to be_a_bad_request 
  end
end

RSpec.describe PasswordResetsController, type: :controller do
  it 'redirects with an error message for an invalid token' do
    get :edit, params: { token: 'invalid_token' } 
    expect(response).to redirect_to(root_path) 
    expect(flash[:alert]).to eq('Your token has expired. Please try again.')
  end
end

RSpec.describe PasswordResetsController, type: :controller do
  it 'throws an error message for empty email' do
    get :create, params: { email:''} 
    expect(flash[:alert]).to eq("Email can't be blank.")
  end
end

RSpec.describe PasswordResetsController, type: :controller do
  it 'throws an error message for invalid email' do
    get :create, params: { email:'asbdas'} 
    expect(flash[:alert]).to eq("Invalid email format. Please enter a valid email address.")
  end
end
  