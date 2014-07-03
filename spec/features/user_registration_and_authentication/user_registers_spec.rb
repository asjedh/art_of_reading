require "spec_helper"

feature "user can register" do
  it "creates a new user if correctly inputted" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path

    fill_in "Email", with: user.email
    fill_in "Username", with: user.username

    fill_in "Password", with: user.password
    fill_in "Confirm password", with: user.password

    within(".form-actions") do
      click_on "Sign up"
    end

    expect(page).to have_content "Logout"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  it "does not create a new user if nothing is inputted" do
    visit new_user_registration_path

    within('.form-actions') do
      click_on "Sign up"
    end

    expect(page).to have_content "Please review the problems below:"
    count = page.body.scan("can't be blank").count
    expect(count).to eql(4)
  end

  it "does not create a new user if password confirmation does not match" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path

    fill_in "Email", with: user.email
    fill_in "Username", with: user.username

    fill_in "Password", with: user.password
    fill_in "Confirm password", with: "notmatching"

    within(".form-actions") do
      click_on "Sign up"
    end

    expect(page).to have_content "doesn't match Password"
    expect(page).to have_content "Sign up"
  end

  it "does not create a new user if email or usersname is already taken is already in databse" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path

    fill_in "Email", with: user.email
    fill_in "Username", with: user.username

    fill_in "Password", with: user.password
    fill_in "Confirm password", with: user.password

    within(".form-actions") do
      click_on "Sign up"
    end

    click_on "Logout"
    visit new_user_registration_path

    fill_in "Email", with: user.email
    fill_in "Username", with: user.username

    fill_in "Password", with: user.password
    fill_in "Confirm password", with: user.password

    within(".form-actions") do
      click_on "Sign up"
    end

    count = page.body.scan("has already been taken").count
    expect(count).to eq(2)
  end


end
