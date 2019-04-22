require 'rails_helper'

describe 'Deleting games' do

  it 'Deleting a game' do
    user = User.create!(user_attributes)
    campaign = Campaign.create!(campaign_attributes(user: user))
    game = Game.create!(game_attributes(campaign: campaign))
    sign_in(user)
    visit campaign_path(campaign)
    click_on game.title
    expect(current_path).to eq(campaign_game_path(campaign, game))

    expect { 
        click_button 'Delete' 
      }.to change(Game, :count)
    expect(current_path).to eq(campaign_path(campaign))
    expect(page).not_to have_text(game.title)

  end
end