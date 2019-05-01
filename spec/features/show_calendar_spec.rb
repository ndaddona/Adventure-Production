require 'rails_helper'

describe 'Viewing the calendar' do
  it 'shows the calendar' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(title: 'Test', start_time: Time.now + 1.days, campaign: campaign)
    sign_in(user)
    visit meetings_path

    expect(page).to have_text("#{meeting.title} - #{meeting.start_time.strftime('%I:%M %P')}")
  end
  it 'filter the calendar' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(title: 'Test', start_time: Time.now + 2.days, campaign: campaign)
    user2 = User.create!(user_attributes(email: 'other@email.com'))
    campaign2 = Campaign.create!(campaign_attributes(name: 'Camp2', user: user2))
    meeting2 = Meeting.create!(title: 'Another', start_time: Time.now + 3.days, campaign: campaign2)
    campaign3 = Campaign.create!(campaign_attributes(name: 'Play', user: user))
    meeting3 = Meeting.create!(title: 'Play', start_time: Time.now + 4.days, campaign: campaign3)
    Signup.create!(campaign_id: campaign3.id, user_id: user2.id)
    sign_in(user2)
    visit meetings_path

    expect(page).to have_text("#{meeting.title} - #{meeting.start_time.strftime('%I:%M %P')}")
    expect(page).to have_text("#{meeting2.title} - #{meeting2.start_time.strftime('%I:%M %P')}")
    expect(page).to have_text("#{meeting3.title} - #{meeting3.start_time.strftime('%I:%M %P')}")

    click_button 'Your Events'

    expect(page).not_to have_text("#{meeting.title} - #{meeting.start_time.strftime('%I:%M %P')}")
    expect(page).to have_text("#{meeting2.title} - #{meeting2.start_time.strftime('%I:%M %P')}")
    expect(page).to have_text("#{meeting3.title} - #{meeting3.start_time.strftime('%I:%M %P')}")
  end
end
