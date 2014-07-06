require 'spec_helper'

feature "user can add a chapter for a book" do
  it "adds chapter with valid chapter detalils" do
    book = FactoryGirl.create(:book)
    chapter = FactoryGirl.build(:chapter, book: book)

    sign_in_as(book.user)
    visit book_chapters_path(book.id)

    fill_in "Title", with: chapter.title

    click_on "Add Chapter"

    expect(page).to have_content("Your chapter has been added.")
    expect(page).to have_content(chapter.title)
  end

  it "does not add chapter without title" do
    book = FactoryGirl.create(:book)

    sign_in_as(book.user)
    visit book_chapters_path(book.id)

    click_on "Add Chapter"

    expect(page).to have_content("You're chapter could not be added. See errors below.")
    expect(page).to have_content("can't be blank")
  end
end
