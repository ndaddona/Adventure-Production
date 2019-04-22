require 'rails_helper'

describe CampaignsController do

  before do
    user = User.create!(user_attributes)
    @campaign = Campaign.create!(campaign_attributes(user: user))
  end

  context "when not signed in" do
    it "cannot reach new campaign page" do
      get :new
      expect(response).to redirect_to(new_session_path)
    end
    it "cannot create new campaign" do
      post :create
      expect(response).to redirect_to(new_session_path)
    end
  end

  context "when not signed in as an admin user" do

    before do
      @non_admin = User.create!(user_attributes(email: "nonadmin@email.com", admin: false))
      session[:user_id] = @non_admin.id
    end


    it "cannot access edit" do
      get :edit, params: { id: @campaign, user_id: @campaign.user.id}

      expect(response).to redirect_to(root_url)
    end

    it "cannot access update" do
      patch :update, params: { id: @campaign, user_id: @campaign.user.id}

      expect(response).to redirect_to(root_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @campaign, user_id: @campaign.user.id}

      expect(response).to redirect_to(root_url)
    end

  end

end
