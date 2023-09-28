require 'rails_helper'

RSpec.describe InstructorReferralController, type: :controller do

    before :each do
        User.create(email: 'user1@gmail.com', password: 'password',user_type:"Instructor")
    end

    describe 'GET #index' do
    it 'renders the referral page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

    # describe 'POST #create' do
    #     it 'creates a new referral link' do
    #     post :create, params: {
    #       user: {
    #         email: 'test@example.com',
    #       }
    #     }, session :{
    #         user_id: User.find_by(email: "user1@gmail.com")
    #     }

    #     expect(response).to redirect_to(user_path(assigns(:user).id))
    #     expect(flash[:notice]).to be_present
    #   end

    # end 

end