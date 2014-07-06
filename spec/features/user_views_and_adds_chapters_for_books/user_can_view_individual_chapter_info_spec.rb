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
end
