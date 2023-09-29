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
        @user = User.find(params[:id])
        @user_id_from_session = @user.id
        @is_instructor = @user.user_type == "Instructor"
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :user_type)
    end
end
