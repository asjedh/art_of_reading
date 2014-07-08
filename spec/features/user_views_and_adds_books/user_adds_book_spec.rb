require "spec_helper"

feature "user can add books" do
  it "creates book with valid details" do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.build(:book, user: user)

    sign_in_as(user)
    visit new_user_book_path(user.id)

    fill_in "Title", with: book.title
    fill_in "Author", with: book.authors
    fill_in "Year", with: book.year
    select "Fantasy", from: "Genre"
    click_on "Add Book"

    expect(page).to have_content("Book added!")
    expect(page).to have_content("Your Notes for #{book.title}")
  end

  it 'searches for books with goodreads API' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit new_user_book_path(user.id)

    fill_in "Search", with: "Lord of the Rings"
    click_on "Search"

    expect(page).to have_content("Search Results for \"Lord of the Rings\"")
    expect(page).to have_content("The Lord of the Rings (The Lord of the Rings, #1-3)")
    expect(page).to have_content("J.R.R. Tolkien")
  end

  it "does not create book with invalid details" do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.build(:book, user: user)

    sign_in_as(user)
    visit new_user_book_path(user.id)
    click_on "Add Book"

    count = page.body.scan("can't be blank").count
    expect(count).to eq(1)
  end


  it "redirects to sign in page if user is not signed in" do
    user = FactoryGirl.create(:user)
    visit new_user_book_path(user.id)
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
