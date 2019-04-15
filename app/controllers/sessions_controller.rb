class SessionsController < ApplicationController

  before_action :set_user
  before_action :require_correct_or_admin

    def new;end

    def create
        if user = User.authenticate(params[:email], params[:password])
          session[:user_id] = user.id
          redirect_to(session[:intended_url] || root_url)
          session[:intended_url] = nil
        else
          redirect_to new_session_path, alert: "Invalid Information"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url
    end

    private

    def set_user
      @user = current_user
    end
  
    def require_correct_or_admin
      unless current_user?(@user) || current_user.admin?
        redirect_to root_url
      end
    end
end
