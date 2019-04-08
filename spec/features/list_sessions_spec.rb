require 'rails_helper'

describe 'Listing the games for a campaign' do
  it 'list the games' do
    campaign = Campaign.create!(name: 'Test', description: 'Testing text', gm: 'Me', players: 'You', category: "MotW")
    game = campaign.games.create!(title: "A game", description: "says stuff")
    visit campaign_games_path(campaign, game)

    expect(page).to have_text('Test')
    expect(page).to have_text('A game')
    expect(page).to have_text('says stuff')

  end
end