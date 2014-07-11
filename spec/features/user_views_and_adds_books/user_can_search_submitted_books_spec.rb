require 'spec_helper'

feature 'user is able to find search box and search' do

  it 'shows a list of relevant books when a user searches' do

  beard = FactoryGirl.create(:beard, title: "tip")
  matching_beard = FactoryGirl.create(:beard, title: "tippity")
  not_matching_beard = FactoryGirl.create(:beard, title: "top")

  visit "/"

  fill_in "search", with: beard.title
  click_on "Search"

  expect(page).to have_content(beard.title)
  expect(page).to have_content(matching_beard.title)
  expect(page).to_not have_content(not_matching_beard.title)

  end
end
