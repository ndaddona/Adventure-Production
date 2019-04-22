require 'rails_helper'

describe 'Edit users' do
  it 'Reach edit the user page' do
    user = User.create!(user_attributes)
    sign_in(user)
    visit user_path(user)
    
    click_button 'Edit'
    expect(current_path).to eq(edit_user_path(user))
    expect(page).to have_text("Email")
  end

  it 'Update the user' do
    user = User.create!(user_attributes)
    sign_in(user)
    visit user_path(user)
    
    click_button 'Edit'
    
    fill_in "Email", with: "new@email.com"
    click_button "Update User"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("new@email.com")

  end

  it 'Enter incorrect value' do
    user = User.create!(user_attributes)
    sign_in(user)
    visit user_path(user)
    
    click_button 'Edit'
    
    fill_in "Email", with: ""
    click_button "Update User"

    expect(current_path).to eq(user_path(user))

  end
  

end
