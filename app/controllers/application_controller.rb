class ApplicationController < ActionController::Base

    def require_signin
        unless current_user
          redirect_to new_session_url
        end
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def current_user?(user)
        current_user == user
    end



    def current_user_admin?
        current_user && current_user.admin?
    end


    helper_method :current_user_admin?
      
    helper_method :current_user?

    helper_method :current_user

    

end
