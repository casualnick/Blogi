class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authenticate_admin, only: [:index]

    def index
        @users = User.all
    end

    def show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create!(user_params)

        session[:user_id] = @user.id

        redirect_to @user
    end
    
    def update
        @user.update(user_params)

        json_response(@user, :no_content)
    end

    def destroy
        session[:user_id] = nil if @user.id == current_user.id
        @user.destroy!
        redirect_to home_path
        
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end

    def set_user
        @user = User.find(params[:id])
    end
end
