class InstructorController < ApplicationController
    def new 
        @instructor = Instructor.new
        @user = User.new
    end

    def create
        specific_user_params = {
            email: user_params[:email],
            password: user_params[:password]
        }
        @user = User.new(specific_user_params)
        @instructor = Instructor.new(instructor_params)

        if valid_inputs? 
            if @user.save 
               @instructor.user_id=@user.userid
               if @instructor.save
                    flash[:success] = "Welcome, #{@instructor.first_name}!"
                    redirect_to root_path
               else
                    @user.destroy # Roll back the user creation if instructor creation fails
                    render 'new'
               end
            else
                render 'new'
            end  
        else
            flash.now[:error] = "Please check your inputs and try again." 
            render 'new'
        end
    end

    def instructor_params
       params.require(:instructor).permit(:first_name, :last_name)
    end

    def user_params
        params.require(:user).permit(:email, :password, :confirm_password)
    end

    def valid_inputs?
        email_valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(instructor_params[:email])
        password_match = instructor_params[:password] == instructor_params[:confirm_password]
    
        email_valid && password_match
    end
end
