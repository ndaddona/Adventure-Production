require 'rails_helper'

describe "Signing in" do

  it "prompts for an email and password" do

    visit new_session_path

    expect(current_path).to eq(new_session_path)

    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
  end

  it "signs in the user if the email/password combination is valid" do
    user = User.create!(user_attributes)
    visit users_path


    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button 'Sign In'

    expect(current_path).to eq(root_path)   

  end

  it "does not sign in the user if the email/password combination is invalid" do
    user = User.create!(user_attributes)

    visit new_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "no match"

    click_button 'Sign In'

    expect(page).to have_text('Invalid')
    expect(page).not_to have_link(user.name)

  end

  it "redirects to the intended page" do
    user = User.create!(user_attributes)

    visit users_url

    expect(current_path).to eq(new_session_path)

    sign_in(user)

    expect(current_path).to eq(root_path)
  end
end