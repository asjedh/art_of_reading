require 'spec_helper'

feature "User signs in through login page" do
  it 'signs in with valid details' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    expect(page).to have_content "Signed in successfully."
  end

  it 'does not sign in with invalid email' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in "Email", with: "random@gmail.com"
    fill_in "Password", with: user.password

    click_on "Sign in"

    expect(page).to have_content "Invalid email or password."
  end

  it 'does not sign in with invalid password' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_on "Sign in"

    expect(page).to have_content "Invalid email or password."
  end
end
