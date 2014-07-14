require 'spec_helper'

feature 'user is able to find search box' do

  it 'shows a list of relevant books when a user searches with title' do

  book = FactoryGirl.create(:book, title: "tip")
  matching_book = FactoryGirl.create(:book, title: "tippity")
  not_matching_book = FactoryGirl.create(:book, title: "top")

  visit root_path
  fill_in "search", with: book.title
  choose "Title"
  click_on "Search"

  expect(page).to have_content(book.title)
  expect(page).to have_content(matching_book.title)
  expect(page).to_not have_content(not_matching_book.title)
  end

  it 'shows relevant books when a user searches with ISBN' do
    book = FactoryGirl.create(:book, isbn_10: "1111111111")
    matching_book = FactoryGirl.create(:book, isbn_13: "1111111111111")
    not_matching_book = FactoryGirl.create(:book, isbn_10: "2222222222")
    other_not_matching_book = FactoryGirl.create(:book, isbn_13: "2222222222222")

    visit root_path
    fill_in "search", with: book.isbn_10
    choose "ISBN"
    click_on "Search"

    expect(page).to have_content(book.title)
    expect(page).to have_content(matching_book.title)
    expect(page).to_not have_content(not_matching_book.title)
    expect(page).to_not have_content(other_not_matching_book.title)
  end

  it 'shows a list of relevant books when a user searches with author' do
    author = FactoryGirl.create(:author)
    books = FactoryGirl.create_list(:book, 10)
    books.each { |book| book.authors << author }
    not_matching_book = FactoryGirl.create(:book)

    visit root_path
    fill_in "search", with: author.name
    choose "Author"
    click_on "Search"

    books.each do |book|
      expect(page).to have_content(book.title)
    end

    expect(page).to_not have_content(not_matching_book.title)
  end

end
