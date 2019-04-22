class CampaignsController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :set_user, only: [:new, :create]
  before_action :set_campaign, except: [:index, :new, :create]
  before_action :require_correct_or_admin, only: [:edit, :update, :destroy]
  
  

  def index
    case params[:scope]
      when 'your_campaigns'
        @signups = Signup.playin(current_user.id)
        @campaigns = []
        current_user.campaigns.each do |running|
          @campaigns << running
        end
        @signups.each do |playin|
          @campaigns << Campaign.find(playin.campaign_id)
        end
      when 'gm'
        @campaigns = []
        current_user.campaigns.each do |running|
          @campaigns << running
        end
      when 'playin'
        @signups = Signup.playin(current_user.id)
        @campaigns = []
        @signups.each do |playin|
          @campaigns << Campaign.find(playin.campaign_id)
        end
      else
        @campaigns = Campaign.all
      end
    if params[:search]
      @campaigns = Campaign.search(params[:search])
    end
  end

  def show
    @joined = @campaign.joined
  end

  def new
    @campaign = @user.campaigns.new
  end

  def create
    @campaign = @user.campaigns.new(campaign_params)
    if @campaign.save
      redirect_to @campaign, notice: "Campaign successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: "Campaign successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_url, alert: "Campaign deleted"
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name,:description,:gm,:players,:image_file_name, :category)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def require_correct_or_admin
    unless current_user?(@campaign.user) || current_user.admin?
      redirect_to root_url
    end
  end

  

end
