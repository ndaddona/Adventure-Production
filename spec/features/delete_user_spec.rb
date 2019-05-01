require 'rails_helper'

describe 'Delete users' do
  it 'Delete the user' do
    user = User.create!(user_attributes)
    sign_in(user)
    visit user_path(user)

    expect do
      click_button 'Delete'
    end.to change(User, :count)
    expect(page).to have_current_path(root_path)
    expect(page).to have_text('User deleted!')
  end
end
