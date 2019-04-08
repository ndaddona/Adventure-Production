require 'rails_helper'

describe 'Viewing the calendar' do
  it 'shows the calendar' do
    campaign = Campaign.create!(name: 'Test', description: 'Testing text', gm: 'Me', players: 'You', category: "MotW")
    meeting = Meeting.create!(title: "Test", start_time: "2019-03-03 10:40:00", campaign: campaign)
    visit meetings_path

    expect(page).to have_text('Test - 10:40 am')

  end
end