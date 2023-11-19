class ProfilesController < ApplicationController

    def show
        @user = User.find(session[:user_id])
        if (@user.user_type.downcase == "instructor")
            @instructor = Instructor.find_by(user_id: @user.id)
            @is_instructor = true
        end
    end

    def edit
        @user = User.find(session[:user_id])
        @instructor = Instructor.find_by(user_id: @user.id)
    end

    def update
        @user = User.find(session[:user_id])
        if (@user.user_type.downcase == "instructor")
            @instructor = Instructor.find_by(user_id: @user.id)
            specific_instructor_params = {
                first_name: profile_params[:first_name],
                last_name: profile_params[:last_name]
            }
            
            if @instructor.update(specific_instructor_params)
                redirect_to profile_path, notice: 'Profile updated successfully'
            else
                render :edit
            end
        end
    end

    private
    def profile_params
        params.require(:instructor).permit(:email, :first_name, :last_name, :other_attributes)
    end
end
