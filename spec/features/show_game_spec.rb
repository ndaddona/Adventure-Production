require 'rails_helper'

describe 'Show a game for a campaign' do
  it 'Show a game' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = campaign.games.create!(title: "A game", description: "says stuff")
    visit campaign_game_path(campaign, game)

    expect(page).to have_text(game.title)
    expect(page).to have_text(game.description)
    expect(page).not_to have_selector(:link_or_button, 'Edit')
    expect(page).not_to have_selector(:link_or_button, 'Delete')

  end

  it 'Show a game to owner' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = campaign.games.create!(title: "A game", description: "says stuff")
    sign_in(user)
    visit campaign_game_path(campaign, game)

    expect(page).to have_text(game.title)
    expect(page).to have_text(game.description)
    expect(page).to have_selector(:link_or_button, 'Edit')
    expect(page).to have_selector(:link_or_button, 'Delete')

  end

  it 'Show a game to user that is not owner' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name:"Other", email:"other@email.com"))
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = campaign.games.create!(title: "A game", description: "says stuff")
    sign_in(user2)
    visit campaign_game_path(campaign, game)

    expect(page).to have_text(game.title)
    expect(page).to have_text(game.description)
    expect(page).not_to have_selector(:link_or_button, 'Edit')
    expect(page).not_to have_selector(:link_or_button, 'Delete')

  end
end