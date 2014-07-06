require "spec_helper"

feature "user can view chapters for a book" do
  it "user views chapters" do
    book = FactoryGirl.create(:book)
    chapters = FactoryGirl.create_list(:chapter, 10, book: book)

    sign_in_as(book.user)
    visit book_chapters_path(book.id)

    chapters.each do |chapter|
      expect(page).to have_content(chapter.title)
    end
  end

  it "redirects to sign in page if user is not signed in" do
    book = FactoryGirl.create(:book)
    chapters = FactoryGirl.create_list(:chapter, 10, book: book)

    visit book_chapters_path(book.id)

    chapters.each do |chapter|
      expect(page).to_not have_content(chapter.title)
    end

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
