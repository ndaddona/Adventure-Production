require 'rails_helper'

describe "Creating a new campaign." do
    it 'Goes to new campaign page' do
        user = User.create!(user_attributes)
        sign_in(user)
        visit root_url
        click_button 'New Campaign'
        expect(page).to have_text("Name")
        expect(page).to have_text("Description")
        expect(page).to have_text("Category")
        expect(page).to have_text("Image file name")
        expect(page).to have_button("Create Campaign")
        expect(page).to have_text("Cancel")

    end

    it 'Saves campaign and shows info' do
        user = User.create!(user_attributes)
        sign_in(user)
        visit root_url
        click_button 'New Campaign'

        fill_in "Name", with: "Nyx"
        fill_in "Description", with: "Heroes saving the world from villains"
        fill_in "Category", with: "Pathfinder"

        click_button 'Create Campaign'
        expect(current_path).to eq(campaign_path(Campaign.last))

        expect(page).to have_text('Nyx')
        expect(page).to have_text('Heroes saving the world from villains')
        expect(page).to have_text(user.name)

    end

    it 'Invalid campaign info' do
        user = User.create!(user_attributes)
        sign_in(user)
        visit root_url
        click_button 'New Campaign'

        fill_in "Name", with: "Nyx"
        fill_in "Category", with: "Pathfinder"

        click_button 'Create Campaign'


        expect(page).to have_text('Description can\'t be blank')


    end

    it "does not save the campaign if it's invalid" do
        user = User.create!(user_attributes)
        sign_in(user)
        visit root_url
        click_button 'New Campaign'
        
        expect { 
          click_button 'Create Campaign' 
        }.not_to change(Campaign, :count)
 
        expect(current_path).to eq(campaigns_path)
        expect(page).to have_text('Description can\'t be blank')
      end
end