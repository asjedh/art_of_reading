require "spec_helper"

feature "user can search books to add with Goodreads API books" do

  it 'searches for books with goodreads API' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit new_user_book_path(user.id)

    fill_in "Search Books", with: "Lord of the Rings"
    click_on "Search"

    expect(page).to have_content("Did you mean one of these books?")
    expect(page).to have_content("The Lord of the Rings (The Lord of the Rings, #1-3)")
    expect(page).to have_content("J.R.R. Tolkien")
  end
end
