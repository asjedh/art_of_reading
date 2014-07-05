require "spec_helper"

feature "user can add books" do
  it "creates book with valid details" do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.build(:book, user: user)

    sign_in_as(user)
    visit new_user_book_path(user.id)

    fill_in "Title", with: book.title
    fill_in "Description", with: book.description
    click_on "Add Book"

    expect(page).to have_content("Book added!")
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.description)
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
