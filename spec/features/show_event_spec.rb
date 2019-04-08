require 'rails_helper'

describe 'Viewing the event' do
  it 'shows the event' do
    campaign = Campaign.create!(name: 'Camp', description: 'Testing text', gm: 'Me', players: 'You', category: "MotW")
    meeting = Meeting.create!(title: "Test", start_time: "2019-03-03 10:40:00", description: 'yup', campaign: campaign)
    visit meeting_path(campaign)

    expect(page).to have_text('Camp')
    expect(page).to have_text('Test')
    expect(page).to have_text('yup')
    expect(page).to have_text('on March 03, 2019 at 10:40am')

  end
end