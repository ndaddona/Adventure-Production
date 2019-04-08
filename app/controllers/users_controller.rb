class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_or_admin, only: [:destroy, :edit, :update]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @plays = @user.plays
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to @user
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
        redirect_to root_url, alert: "User deleted!"
      end

    private

    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def require_correct_or_admin
        @user = User.find(params[:id])
        unless current_user?(@user) || current_user.admin?
          redirect_to root_url
        end
    end


end
