require 'rails_helper'

describe 'Show a game for a campaign' do
  it 'Show a game' do
    campaign = Campaign.create!(name: 'Test', description: 'Testing text', gm: 'Me', players: 'You', category: "MotW")
    game = campaign.games.create!(title: "A game", description: "says stuff")
    visit campaign_game_path(campaign, game)

    expect(page).to have_text('A game')
    expect(page).to have_text('says stuff')

  end
end