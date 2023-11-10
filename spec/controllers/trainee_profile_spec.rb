require 'rails_helper'

RSpec.describe TraineeProfileController, type: :controller do
  describe 'GET #show' do
    context 'when trainee is found' do
      let(:user_id) { 1 } # Replace with the specific user ID used for testing
      
      before do
        allow(Trainee).to receive(:find_by).and_return(Trainee.new) # Stub the Trainee model
        get :show, session: { user_id: user_id }
      end

      it 'assigns @trainee' do
        expect(assigns(:trainee)).to be_a(Trainee)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    context 'when trainee is not found' do
      let(:user_id) { 2 } # Replace with a user ID that won't find a trainee
      
      before do
        allow(Trainee).to receive(:find_by).and_return(nil) # Stub the Trainee model
        get :show, session: { user_id: user_id }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
