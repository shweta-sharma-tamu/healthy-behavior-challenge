class InstructorController < ApplicationController
    def new 
        @instructor = Instructor.new
        @user = User.new
    end

    def create
        if user_params[:email] == '' or user_params[:password] == ''
            flash[:error] = "Incorrect email or password. Please try again."
            redirect_to instructor_signup_path
            return
        end

        if user_params[:password] != user_params[:confirm_password]
            flash[:error] = "Password Mismatch."
            redirect_to instructor_signup_path
            return
        end

        specific_user_params = {
            email: user_params[:email],
            password: user_params[:password],
            user_type: 'instructor'
        }
        @user = User.new(specific_user_params)

        if valid_inputs? 
            puts "Valid email"
            if @user.save 
    
               specific_instructor_params = {
                    user_id: @user.id,
                    first_name: user_params[:first_name],
                    last_name: user_params[:last_name],
                }

               @instructor = Instructor.new(specific_instructor_params)
               if @instructor.save
                    flash[:notice] = "Welcome, #{@instructor.first_name}!"
                    session[:user_id] = @user.id
                    redirect_to user_path(session[:user_id])
               else
                    flash[:notice] = "Signup failed!"
                    @user.destroy
                    render 'new'
               end
            else
                render 'new'
            end  
        else
            flash.now[:error] = "Please enter valid email and try again." 
            render 'new'
        end
    end

    def user_params
        params.require(:user).permit(:email, :password, :confirm_password, :first_name, :last_name)
    end

    def valid_inputs?
        email_valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(user_params[:email])
        email_valid
    end
end
