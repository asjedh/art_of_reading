require 'spec_helper'

feature 'user can register ' do
  it "creates a new user if correctly inputted" do
    user = FactoryGirl.build(:user)
    visit "/users/sign_up"

    fill_in "Email", with: user.email
    fill_in "User name", with: user.user_name

    fill_in "Password", with: user.password
    fill_in "Confirm password", with: user.password

    within('.form-actions') do
      click_on "Sign up"
    end

    expect(page).to have_content "Logout"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  it "does not create a new user if nothing is inputted" do
    visit "/users/sign_up"

    within('.form-actions') do
      click_on "Sign up"
    end

    expect(page).to have_content "Please review the problems below:"
    count = page.body.scan("can't be blank").count
    expect(count).to eql(4)
  end

  it "does not create a new user if password confirmation does not match" do
    user = FactoryGirl.build(:user)
    visit "/users/sign_up"

    fill_in "Email", with: user.email
    fill_in "User name", with: user.user_name

    fill_in "Password", with: user.password
    fill_in "Confirm password", with: 'notmatching'

    within('.form-actions') do
      click_on "Sign up"
    end

    expect(page).to have_content "doesn't match Password"
    expect(page).to have_content "Sign up"
  end

end
