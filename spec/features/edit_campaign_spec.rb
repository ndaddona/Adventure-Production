require 'rails_helper'

describe "Edit a campaign." do
    it 'Goes to edit campaign page' do
        user = User.create!(user_attributes)
        campaign = Campaign.create!(campaign_attributes(user:user))
        sign_in(user)
        visit campaign_path(campaign)
        click_button 'Edit'
        expect(page).to have_text("Name")
        expect(page).to have_text("Description")
        expect(page).to have_text("Category")
        expect(page).to have_text("Image file name")
        expect(page).to have_button("Update Campaign")
        expect(page).to have_text("Cancel")

    end

    it 'Updates campaign and shows info' do
        user = User.create!(user_attributes)
        campaign = Campaign.create!(campaign_attributes(user:user))
        sign_in(user)
        visit campaign_path(campaign)
        click_button 'Edit'

        fill_in "Name", with: "Nyx"
        fill_in "Description", with: "Heroes saving the world from villains"
        fill_in "Category", with: "Pathfinder"

        click_button 'Update Campaign'
        expect(current_path).to eq(campaign_path(campaign))

        expect(page).to have_text("Nyx")
        expect(page).to have_text("Heroes saving the world from villains")
        expect(page).to have_text(user.name)

    end

    it 'Invalid campaign info' do
        user = User.create!(user_attributes)
        campaign = Campaign.create!(campaign_attributes(user:user))
        sign_in(user)
        visit campaign_path(campaign)
        click_button 'Edit'

        fill_in "Name", with: "Nyx"
        fill_in "Description", with: ""
        fill_in "Category", with: "Pathfinder"

        click_button 'Update Campaign'


        expect(page).to have_text('Description can\'t be blank')


    end
end