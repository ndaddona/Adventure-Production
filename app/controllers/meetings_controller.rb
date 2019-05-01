class MeetingsController < ApplicationController
  before_action :require_signin
  before_action :set_campaign, except: %i[index show]
  before_action :require_correct_or_admin, except: %i[index show]

  def index
    case params[:scope]
    when 'your_meetings'
      your_events
    else
      @meetings = Meeting.all
    end
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
      redirect_to meetings_url, notice: 'Event created.'
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
      redirect_to @meeting, notice: 'Event updated.'
    else
      render :edit
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    redirect_to meetings_url, alert: 'Event canceled.'
  end

  private

  def meeting_params
    params.require(:meeting).permit(:title, :start_time, :description)
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def require_correct_or_admin
    unless current_user?(@campaign.user) || current_user.admin?
      redirect_to root_url
    end
  end

  def your_events
    signups = Signup.playin(current_user.id)
    users_meetings = Meeting.none.to_a
    current_user.campaigns.each do |running|
      users_meetings += running.meetings
    end
    signups.each do |playin|
      campaign = Campaign.find(playin.campaign_id)
      users_meetings += campaign.meetings
    end
    @meetings = Meeting.where(id: users_meetings.map(&:id))
  end
end
