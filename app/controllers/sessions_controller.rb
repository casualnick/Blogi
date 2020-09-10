class SessionsController < ApplicationController


    def new
    end

    def create
        @user = User.find_by(email: email)
        @user.id = session[:user_id] if @user.authenticate(password)
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path
    end
end
