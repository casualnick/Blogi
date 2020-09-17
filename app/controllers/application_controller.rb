class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include Response
    include ExceptionHandler

    helper_method :current_user


    private

    def current_user
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
    end

    def authenticate_admin
        unless @current_user.nil?
            unless @current_user.role == :admin
                redirect_to @user_path, alert: 'you have to be admin to access this action'
            end
        else
            authenticate_login
        end
    end

    def authenticate_login
        redirect_to login_path, alert: 'You have to be logged to access this action' if current_user.nil?
    end

end
