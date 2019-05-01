require 'rails_helper'

describe 'Creating a new game.' do
  it 'Goes to new game page' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    sign_in(user)
    visit campaign_url(campaign)

    click_button 'New Game'

    expect(page).to have_text('Title')
    expect(page).to have_text('Description')
    expect(page).to have_text('Cancel')
    expect(page).to have_button('Create Game')
  end

  it 'Saves new game' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    sign_in(user)
    visit campaign_url(campaign)

    click_button 'New Game'
    fill_in 'Title', with: 'Rspec'
    fill_in 'Description', with: 'Testing'

    click_button 'Create Game'
    expect(page).to have_current_path(campaign_path(campaign))
    expect(page).to have_text('Rspec')
  end

  it "does not save the game if it's invalid" do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    sign_in(user)
    visit campaign_url(campaign)

    click_button 'New Game'

    fill_in 'Description', with: 'Testing'

    expect do
      click_button 'Create Game'
    end.not_to change(Game, :count)

    expect(page).to have_current_path(campaign_games_path(campaign))
    game = Game.last
    expect(page).to have_text("Title can't be blank")
  end
end
