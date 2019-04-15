require 'rails_helper'

describe 'Viewing the event' do
  it 'shows the event' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(title: "Test", start_time: "2019-03-03 10:40:00", description: 'yup', campaign: campaign)
    visit meeting_path(campaign)

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(meeting.title)
    expect(page).to have_text(meeting.description)
    expect(page).to have_text('on March 03, 2019 at 10:40am')
    expect(page).not_to have_selector(:link_or_button, 'Edit')
    expect(page).not_to have_selector(:link_or_button, 'Delete')

  end

  it 'shows the event for owner' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(title: "Test", start_time: "2019-03-03 10:40:00", description: 'yup', campaign: campaign)
    sign_in(user)
    visit meeting_path(campaign)

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(meeting.title)
    expect(page).to have_text(meeting.description)
    expect(page).to have_text('on March 03, 2019 at 10:40am')
    expect(page).to have_selector(:link_or_button, 'Edit')
    expect(page).to have_selector(:link_or_button, 'Delete')

  end

  it 'shows the event as user that is not owner' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name:"Other", email:"other@email.com"))
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(title: "Test", start_time: "2019-03-03 10:40:00", description: 'yup', campaign: campaign)
    sign_in(user2)
    visit meeting_path(campaign)

    expect(page).to have_text(campaign.name)
    expect(page).to have_text(meeting.title)
    expect(page).to have_text(meeting.description)
    expect(page).to have_text('on March 03, 2019 at 10:40am')
    expect(page).not_to have_selector(:link_or_button, 'Edit')
    expect(page).not_to have_selector(:link_or_button, 'Delete')

  end

end