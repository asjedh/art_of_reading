require "spec_helper"

feature "user can view chapter for a chapter" do
  it "user views chapter information" do

    chapter = FactoryGirl.create(:chapter)

    sign_in_as(chapter.book.user)
    visit chapter_path(chapter.id)

    expect(page).to have_content(chapter.title)
    expect(page).to have_content(chapter.tldr)
    expect(page).to have_content(chapter.summary)
    expect(page).to have_content(chapter.reflection)
    expect(page).to have_content(chapter.key_concepts)
  end

  # it "redirects to sign in page if user is not signed in" do
  #   book = FactoryGirl.create(:book)
  #   chapters = FactoryGirl.create_list(:chapter, 10, book: book)

  #   visit book_chapters_path(book.id)

  #   chapters.each do |chapter|
  #     expect(page).to_not have_content(chapter.title)
  #   end

  #   expect(page).to have_content("You need to sign in or sign up before continuing.")
  # end
end
