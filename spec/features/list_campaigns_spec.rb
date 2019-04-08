require 'rails_helper'

describe 'Viewing the list of campaigns' do
  it 'shows the campaigns' do
    campaign = Campaign.create!(name: 'Test', description: 'Testing text', gm: 'Me', players: 'You', category: "MotW")
    visit campaign_url(campaign)
    

    visit 'http://example.com/campaigns'


    expect(page).to have_text('Test')
    expect(page).to have_text('Testing text')
    expect(page).to have_text('MotW')
  end
end
