require 'rails_helper'

describe 'Updating game.' do
  it 'Goes to edit game page' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = Game.create!(game_attributes(campaign: campaign))
    sign_in(user)
    visit campaign_game_path(campaign, game)

    click_button 'Edit'

    expect(page).to have_text('Title')
    expect(page).to have_text('Description')
    expect(page).to have_text('Cancel')
    expect(page).to have_button('Update Game')
  end

  it 'Updates game' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = Game.create!(game_attributes(campaign: campaign))
    sign_in(user)
    visit campaign_game_path(campaign, game)

    click_button 'Edit'

    fill_in 'Title', with: 'Update_spec'
    fill_in 'Description', with: 'New description'

    click_button 'Update Game'
    expect(page).to have_current_path(campaign_game_path(campaign, game))

    expect(page).to have_text('Update_spec')
    expect(page).to have_text('New description')
  end

  it "does not update the game if it's invalid" do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = Game.create!(game_attributes(campaign: campaign))
    sign_in(user)
    visit campaign_game_path(campaign, game)

    click_button 'Edit'

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'New description'

    click_button 'Update Game'
    expect(page).to have_current_path(campaign_game_path(campaign, game))

    expect(page).to have_text("Title can't be blank")
  end
end
