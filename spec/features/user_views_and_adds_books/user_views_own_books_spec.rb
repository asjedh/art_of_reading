feature "user can view their own books" do
  it "shows all books that user has added" do
    user = FactoryGirl.create(:user)
    books = FactoryGirl.create_list(:book, 5, user: user)

    sign_in_as(user)
    visit user_books_path(user.id)

    books.each do |book|
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.description)
    end
  end
end
