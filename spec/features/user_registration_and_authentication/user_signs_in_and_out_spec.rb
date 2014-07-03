# require 'spec_helper'

# feature "User signs in through login page"
#   it 'signs in with valid details' do
#     user = FactoryGirl.create(:user)
#     visit new_user_session_path

#     fill_in "Email", with: user.email
#     fill_in "Password", with: user.password

#     click_on "Sign in"

#     expect(page).to have_content "You have successfully signed in!"
#   end

#   it 'does not sign in with invalid email' do
#     user = FactoryGirl.create(:user)
#     visit new_user_session_path

#     fill_in "Email", with: "random@gmail.com"
#     fill_in "Password", with: user.password

#     click_on "Sign in"

#     expect(page).to have_content "Invalid details"
#   end

#   it 'does not sign in with invalid password' do
#     user = FactoryGirl.create(:user)
#     visit new_user_session_path

#     fill_in "Email", with: user.email
#     fill_in "Password", with: "password"

#     click_on "Sign in"

#     expect(page).to have_content "Invalid details"
#   end
# end
