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
            if @current_user.role == :admin
                redirect_to new_user_path
                @current_user.errors.add(:role, message: 'You have to be admin to access this action' )
            end
        end
    end

end
