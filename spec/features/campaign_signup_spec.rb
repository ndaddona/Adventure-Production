require 'rails_helper'

describe 'User joins a campaign.' do
  it 'Go to campaign sign up page' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    sign_in(user)
    visit root_url

    click_button 'Join a Campaign'

    expect(page).to have_text('Join A Campaign')
    expect(page).to have_text('Campaigns')
    expect(page).to have_button('Join')
    expect(page).to have_text('Cancel')
  end

  it 'Join a campaign' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: 'Human', email: 'human@email.com'))
    campaign = Campaign.create!(campaign_attributes(user: user))
    campaign2 = Campaign.create!(campaign_attributes(name: 'two', user: user))
    sign_in(user2)
    visit root_url

    click_button 'Join a Campaign'

    select campaign2.name
    click_button 'Join'

    expect(page).to have_current_path(user_path(user2))
    expect(page).to have_text(user2.name)
    expect(page).to have_text(campaign2.name)
  end

  it 'Appears on player list for campaign' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: 'Human', email: 'human@email.com'))
    campaign = Campaign.create!(campaign_attributes(user: user))
    campaign2 = Campaign.create!(campaign_attributes(name: 'two', user: user))
    sign_in(user2)
    visit root_url

    click_button 'Join a Campaign'

    select campaign2.name
    click_button 'Join'

    visit campaign_path(campaign2)
    expect(page).to have_text(user2.name)
  end
end
