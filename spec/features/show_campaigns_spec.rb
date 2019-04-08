require 'rails_helper'

describe 'Showing the campaigns' do
  it 'shows the campaign' do
    campaign = Campaign.create!(name: 'Test', description: 'Testing text', gm: 'Me', players: 'You', category: "MotW")
    game = campaign.games.create!(title: "A game", description: "says stuff")
    visit campaign_url(campaign)
    

    expect(page).to have_text('Testing text')
    expect(page).to have_text('Me')
    expect(page).to have_text('You')

    expect(page).to have_text('A game')
    expect(page).to have_text('says stuff')

  end
end
