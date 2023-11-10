require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
    before do
        @user = User.create!(email: 'instructor2@example.com', password: 'abcdef',user_type: "Instructor")
        @instructor = Instructor.create(user_id: @user.id, first_name: "John", last_name: "Doe")
        session[:user_id] = @user.id
    end

    describe 'GET #show' do
        context 'when logged in as an instructor' do
        before do
            get :show
        end

        it 'renders the show template' do
            expect(response).to render_template(:show)
        end

        it 'assigns the correct user and instructor' do
            expect(assigns(:user)).to eq(@user)
            expect(assigns(:instructor)).to eq(@instructor)
        end
        end
    end

    describe 'GET #edit' do
        context 'when logged in as an instructor' do
        before do
            get :edit
        end

        it 'renders the edit template' do
            expect(response).to render_template(:edit)
        end

        it 'assigns the correct user and instructor' do
            expect(assigns(:user)).to eq(@user)
            expect(assigns(:instructor)).to eq(@instructor)
        end
        end
    end

    describe 'PATCH #update' do
        context 'when logged in as an instructor' do

            context 'with valid params' do
                let(:valid_params) { { instructor: { first_name: 'NewJohn', last_name: 'NewDoe' } } }

                it 'updates the instructor profile' do
                    patch :update, params: valid_params
                    @instructor.reload
                    expect(@instructor.first_name).to eq('NewJohn')
                    expect(@instructor.last_name).to eq('NewDoe')
                end

                it 'redirects to the profile page with a success notice' do
                    patch :update, params: valid_params
                    expect(response).to redirect_to(profile_path)
                    expect(flash[:notice]).to eq('Profile updated successfully')
                end
            end

        end
    end
end
