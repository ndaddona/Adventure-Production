require 'rails_helper'

describe MeetingsController do

  before do
    user = User.create!(user_attributes)
    @campaign = Campaign.create!(campaign_attributes(user: user))
    @meeting = Meeting.create!(meeting_attributes(campaign: @campaign))
  end

  context "when not signed in as an admin user" do

    before do
      non_admin = User.create!(user_attributes(email: "nonadmin@email.com", admin: false))
      session[:user_id] = non_admin.id
    end

    it "cannot access new" do
        get :new, params: {campaign_id: @campaign.id}
  
        expect(response).to redirect_to(root_url)
    end

    it "cannot access create" do
        post :create, params: {campaign_id: @campaign.id}
  
        expect(response).to redirect_to(root_url)
    end

    it "cannot access edit" do
      get :edit, params: { id: @meeting.id, campaign_id: @campaign.id}

      expect(response).to redirect_to(root_url)
    end

    it "cannot access update" do
      patch :update, params: { id: @meeting.id, campaign_id: @campaign.id}

      expect(response).to redirect_to(root_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @meeting.id, campaign_id: @campaign.id}

      expect(response).to redirect_to(root_url)
    end

  end

end
