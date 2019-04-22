require 'rails_helper'

describe 'Deleting events' do

  it 'Deleting an event' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(title: "Test", start_time: "2019-03-03 10:40:00", description: 'yup', campaign: campaign)
    sign_in(user)
    visit meeting_path(meeting)

    expect { 
        click_button 'Delete' 
      }.to change(Meeting, :count)
    expect(current_path).to eq(meetings_path)
    expect(page).to have_text("Event canceled.")

  end
end