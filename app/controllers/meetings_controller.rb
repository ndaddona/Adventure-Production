class MeetingsController < ApplicationController

before_action :set_campaign, except: [:index, :show]
before_action :require_correct_or_admin, except: [:index, :show]

    def index
        @meetings = Meeting.all
    end

    def show
        @meeting = Meeting.find(params[:id])
    end

    def new
        @meeting = @campaign.meetings.new
    end

    def create
        @meeting = @campaign.meetings.new(meeting_params)
        if @meeting.save
            redirect_to meetings_url, notice: "Event created."
        else
            render :new
        end
    end

    def edit
        @meeting = @campaign.meetings.find(params[:id])
    end
    
    def update
        @meeting = @campaign.meetings.find(params[:id])
        if @meeting.update(meeting_params)
          redirect_to @meeting, notice: "Event updated."
        else
          render :edit
        end
    end

    def destroy
        @meeting = Meeting.find(params[:id])
        @meeting.destroy
        redirect_to meetings_url, alert: "Event canceled."
    end


    private
    def meeting_params
        params.require(:meeting).permit(:title,:start_time, :description)
    end

    def set_campaign
        @campaign = Campaign.find(params[:campaign_id])
    end

    def require_correct_or_admin
        @user = @campaign.user
        unless current_user?(@user) || current_user.admin?
          redirect_to root_url
        end
    end
end
