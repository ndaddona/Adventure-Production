class SessionsController < ApplicationController
  def new; end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to(root_url)
    else
      redirect_to new_session_path, alert: 'Invalid Information'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
