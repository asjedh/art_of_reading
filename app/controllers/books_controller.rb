class BooksController < ApplicationController
  def index
    authenticate_user!
    @user = User.find(params[:user_id])
    @books = @user.books
  end

  def all_books_index
    @all_books = Book.order("created_at DESC")
  end
end
