require 'rails_helper'

describe "Creating a new calendar event." do
    it 'Goes to new event page' do
        user = User.create!(user_attributes)
        campaign = Campaign.create!(campaign_attributes(user: user))
        sign_in(user)
        visit campaign_url(campaign)

        click_button 'New Event'

        expect(page).to have_text("Title")
        expect(page).to have_text("Description")
        expect(page).to have_text("Start time")
        expect(page).to have_text("Cancel")
        expect(page).to have_button("Create Meeting")

    end

    it 'Saves new event' do
        user = User.create!(user_attributes)
        campaign = Campaign.create!(campaign_attributes(user: user))
        sign_in(user)
        visit campaign_url(campaign)

        click_button 'New Event'

        fill_in "Title", with: "Rspec"
        fill_in "Description", with: "Testing"

        click_button 'Create Meeting'
        meeting = Meeting.last
        expect(current_path).to eq(meetings_path)

        visit meeting_path(meeting)
        expect(page).to have_text(meeting.title)
        expect(page).to have_text(meeting.description)
        expect(page).to have_text("2019")

    end

    it "does not save the event if it's invalid" do
        user = User.create!(user_attributes)
        campaign = Campaign.create!(campaign_attributes(user: user))
        sign_in(user)
        visit campaign_url(campaign)

        click_button 'New Event'

        fill_in "Title", with: ""
        fill_in "Description", with: "Testing"

        click_button 'Create Meeting'

        expect { 
          click_button 'Create Meeting' 
        }.not_to change(Meeting, :count)
 
        expect(current_path).to eq(meetings_path)
        expect(page).to have_text("Title can't be blank")
    end


end