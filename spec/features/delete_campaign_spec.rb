require 'rails_helper'

describe 'Delete the campaigns' do
  it 'Delete the campaign' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    sign_in(user)
    visit root_url
    click_on campaign.name
    
    expect { 
      click_button 'Delete' 
    }.to change(Campaign, :count)
    expect(current_path).to eq(campaigns_path)
    expect(page).not_to have_text(campaign.name)
    expect(page).to have_text("Campaign deleted")
  end
  

end
