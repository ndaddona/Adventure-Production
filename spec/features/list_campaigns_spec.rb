require 'rails_helper'

describe 'Viewing the list of campaigns' do
  it 'shows the campaigns' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))

    visit campaigns_path

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(campaign.description)
    expect(page).to have_text(campaign.category)

    expect(page).not_to have_selector(:link_or_button, 'New Campaign')
    expect(page).not_to have_selector(:link_or_button, 'Join a Campaign')
    expect(page).not_to have_selector(:link_or_button, 'All Campaigns')
    expect(page).not_to have_selector(:link_or_button, 'Your Campaigns')
    expect(page).not_to have_selector(:link_or_button, 'Campaigns as GM')
    expect(page).not_to have_selector(:link_or_button, 'Campaigns as Player')
  end

  it 'shows the action to signed in user' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    sign_in(user)

    visit campaigns_path

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(campaign.description)
    expect(page).to have_text(campaign.category)

    expect(page).to have_selector(:link_or_button, 'New Campaign')
    expect(page).to have_selector(:link_or_button, 'Join a Campaign')
    expect(page).to have_selector(:link_or_button, 'All Campaigns')
    expect(page).to have_selector(:link_or_button, 'Your Campaigns')
    expect(page).to have_selector(:link_or_button, 'Campaigns as GM')
    expect(page).to have_selector(:link_or_button, 'Campaigns as Player')
  end

  it 'Search for campaigns' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    campaign2 = Campaign.create!(campaign_attributes(name: 'Another', description: 'one', user: user))

    visit campaigns_path

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(campaign2.name)

    fill_in 'Search for...', with: 'Another'
    click_button 'Search'

    expect(page).to have_text(campaign2.name)
    expect(page).not_to have_text(campaign.name)
  end

  it 'Filter for campaigns involved in' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: 'Bob', email: 'bob@email.com'))
    campaign = Campaign.create!(campaign_attributes(user: user))
    campaign2 = Campaign.create!(campaign_attributes(name: 'Another', description: 'one', user: user2))
    campaign3 = Campaign.create!(campaign_attributes(name: 'Third', description: 'Join', user: user))
    signup = Signup.create!(campaign_id: 3, user_id: 2)
    sign_in(user2)

    visit campaigns_path

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(campaign2.name)
    expect(page).to have_text(campaign3.name)

    click_button 'Your Campaigns'

    expect(page).to have_text(campaign2.name)
    expect(page).to have_text(campaign3.name)
    expect(page).not_to have_text(campaign.name)
  end

  it 'Filter for campaigns as owner only' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: 'Bob', email: 'bob@email.com'))
    campaign = Campaign.create!(campaign_attributes(user: user))
    campaign2 = Campaign.create!(campaign_attributes(name: 'Another', description: 'one', user: user2))
    campaign3 = Campaign.create!(campaign_attributes(name: 'Third', description: 'Join', user: user))
    signup = Signup.create!(campaign_id: 3, user_id: 2)
    sign_in(user2)

    visit campaigns_path

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(campaign2.name)
    expect(page).to have_text(campaign3.name)

    click_button 'Campaigns as GM'

    expect(page).to have_text(campaign2.name)
    expect(page).not_to have_text(campaign.name)
    expect(page).not_to have_text(campaign3.name)
  end

  it 'Filter for campaigns as player only' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: 'Bob', email: 'bob@email.com'))
    campaign = Campaign.create!(campaign_attributes(user: user))
    campaign2 = Campaign.create!(campaign_attributes(name: 'Another', description: 'one', user: user2))
    campaign3 = Campaign.create!(campaign_attributes(name: 'Third', description: 'Join', user: user))
    signup = Signup.create!(campaign_id: 3, user_id: 2)
    sign_in(user2)

    visit campaigns_path

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(campaign2.name)
    expect(page).to have_text(campaign3.name)

    click_button 'Campaigns as Player'

    expect(page).to have_text(campaign3.name)
    expect(page).not_to have_text(campaign.name)
    expect(page).not_to have_text(campaign2.name)
  end
end
