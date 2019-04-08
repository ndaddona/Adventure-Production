class SignupsController < ApplicationController

    def new
        @signup = Signup.new  
    end

    def create
        @signup = Signup.new(signup_params)
        if @signup.save
            redirect_to current_user, notice: "Campaign joined!"
        else
            render :new
        end
    end

    def destroy
        @campaign = Campaign.find(params[:campaign_id])
        @user = User.find(params[:user_id])
        @signup = Signup.find_by(campaign_id: @campaign.id, user_id: @user.id)
        @signup.destroy
        redirect_to @campaign, alert: "Player was removed"
    end

    private

    def signup_params
        params.require(:signup).permit(:campaign_id, :user_id)
    end


end
