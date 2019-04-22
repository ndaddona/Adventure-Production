require 'rails_helper'

describe 'Delete users' do
  it 'Delete the user' do
    user = User.create!(user_attributes)
    sign_in(user)
    visit user_path(user)
    
    expect { 
      click_button 'Delete' 
    }.to change(User, :count)
    expect(current_path).to eq(root_path)
    expect(page).to have_text("User deleted!")
  end
  

end
