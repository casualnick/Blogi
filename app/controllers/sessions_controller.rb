class SessionsController < ApplicationController


    def new
        @user = User.new
    end

    def create
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password]) && @user
            session[:user_id] = @user.id
            redirect_to @user
        else 
            flash.now.alert = 'Wrong email or password'
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path
    end
end
