require 'rails_helper'

describe 'Remove user from games' do
  it 'Owner removes a user' do
    user = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: 'Bob', email: 'bob@email.com'))
    campaign = Campaign.create!(campaign_attributes(user: user))
    signup = Signup.create!(campaign_id: 1, user_id: 2)
    sign_in(user)
    visit campaign_path(campaign)

    expect(page).to have_text(user2.name)

    expect do
      click_button 'Remove'
    end.to change(Signup, :count)
    expect(page).to have_current_path(campaign_path(campaign))
    expect(page).to have_text('Player was removed')
    expect(page).not_to have_text(user2.name)
  end
end
