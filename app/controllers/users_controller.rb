class UsersController < ApplicationController

    def new
        @user=User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render 'sessions/new'
        end
    end

    def show
        user_id =  params[:id]
        @user = User.find(user_id)
        @user_id_from_session = @user.id
        @is_instructor = @user.user_type == "Instructor"
        if @is_instructor
            @instructor = Instructor.find_by(user_id: user_id)
            if @instructor
                redirect_to instructor_path(@instructor)
              else
                render plain: 'Instructor not found', status: :not_found
              end
        else
            redirect_to todo_list_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :user_type)
    end
end

