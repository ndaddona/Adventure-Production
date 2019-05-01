require 'rails_helper'

describe 'Signing up a new user.' do
  it 'Correct new user page' do
    visit new_user_path
    expect(page).to have_text('Name')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
    expect(page).to have_text('Confirm Password')
    expect(page).to have_button('Create User')
    expect(page).to have_text('Cancel')
  end

  it 'Saves campaign and shows info' do
    visit new_user_path

    fill_in 'Name', with: 'Test'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'Password'
    fill_in 'Confirm Password', with: 'Password'

    click_button 'Create User'
    expect(page).to have_current_path(new_session_path)

    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'Password'
    click_button 'Sign In'

    expect(page).to have_current_path(root_path)
    visit users_path
    click_on 'Test'

    expect(page).to have_text('Test')
    expect(page).to have_text('test@email.com')
  end

  it 'Mismatched passwords' do
    visit new_user_path

    fill_in 'Name', with: 'Test'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'Password'
    fill_in 'Confirm Password', with: 'Pass'

    expect do
      click_button 'Create User'
    end.not_to change(User, :count)

    expect(page).to have_current_path(users_path)
    expect(page).to have_text('Password confirmation doesn\'t match Password')
  end

  it "does not save the user if it's invalid" do
    visit new_user_path

    fill_in 'Name', with: 'Test'
    fill_in 'Password', with: 'Password'
    fill_in 'Confirm Password', with: 'Password'

    expect do
      click_button 'Create User'
    end.not_to change(User, :count)

    expect(page).to have_current_path(users_path)
    expect(page).to have_text('Email can\'t be blank')
  end
end
