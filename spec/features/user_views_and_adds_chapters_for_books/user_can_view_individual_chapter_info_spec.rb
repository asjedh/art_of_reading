require "spec_helper"

feature "user can view chapter for a chapter" do

  it "shows chapter information if user visits chapter show page" do
    chapter = FactoryGirl.create(:chapter)

    sign_in_as(chapter.book.user)
    visit chapter_path(chapter.id)

    expect(page).to have_content(chapter.title)
    expect(page).to have_content(chapter.tldr)
    expect(page).to have_content(chapter.summary)
    expect(page).to have_content(chapter.reflection)
    expect(page).to have_content(chapter.key_concepts)
  end

   it "redirects to login if user is not signed in" do
    chapter = FactoryGirl.create(:chapter)

    visit chapter_path(chapter.id)

    expect(page).to_not have_content(chapter.title)
    expect(page).to_not have_content(chapter.tldr)
    expect(page).to_not have_content(chapter.summary)
    expect(page).to_not have_content(chapter.reflection)
    expect(page).to_not have_content(chapter.key_concepts)
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
