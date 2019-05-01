require 'rails_helper'

describe 'Updating calendar event.' do
  it 'Goes to edit event page' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(meeting_attributes(campaign: campaign))
    sign_in(user)
    visit meeting_path(meeting)

    click_button 'Edit'

    expect(page).to have_text('Title')
    expect(page).to have_text('Description')
    expect(page).to have_text('Start time')
    expect(page).to have_text('Cancel')
    expect(page).to have_button('Update Meeting')
  end

  it 'Updates event' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(meeting_attributes(campaign: campaign))
    sign_in(user)
    visit meeting_path(meeting)

    click_button 'Edit'

    fill_in 'Title', with: 'Update_spec'
    fill_in 'Description', with: 'New description'

    click_button 'Update Meeting'
    expect(page).to have_current_path(meeting_path(meeting))

    expect(page).to have_text('Update_spec')
    expect(page).to have_text('New description')
    expect(page).to have_text('2019')
  end

  it 'Incorrect event info entered' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    meeting = Meeting.create!(meeting_attributes(campaign: campaign))
    sign_in(user)
    visit meeting_path(meeting)

    click_button 'Edit'

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'New description'

    expect do
      click_button 'Update Meeting'
    end.not_to change(Meeting, :count)
    expect(page).to have_current_path(meeting_path(meeting))
    expect(page).to have_text("Title can't be blank")
  end
end
