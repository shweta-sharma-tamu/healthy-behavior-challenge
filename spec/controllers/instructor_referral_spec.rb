require 'rails_helper'

RSpec.describe InstructorReferralController, type: :controller do

    before :each do
        user = User.create(email: 'user1@gmail.com', password: 'password',user_type:"Instructor")
        session[:user_id] = user.id
    end

    describe 'GET #index' do

    context 'when user is not signed in' do
      before do
        session[:user_id] = nil
      end

      it 'sets an alert flash message' do
        get :index
        expect(flash[:alert]).to eq('You must be signed in to access this page.')
      end
    end


    it 'renders the referral page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

    describe 'POST #create' do
        it 'creates a new referral link if email present' do
        post :create, params: {
            email: 'test@example.com',
        }, session: {
            user_id: User.find_by(email: "user1@gmail.com").id
        }
        expect(flash[:notice]).to be_present
      end
      it 'shows errors if email is not valid' do
        post :create, params: {
            email: '',
        }, session: {
            user_id: User.find_by(email: "user1@gmail.com").id
        }
        expect(flash[:error]).to be_present
      end

    end 

end