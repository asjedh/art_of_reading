class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:all_books_index, :show]

  def index
    @user = current_user
    @books = @user.books
  end

  def all_books_index
    @all_books = Book.order("created_at DESC")
  end

  def new
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @user = current_user
    @book.user = @user

    if @book.save
      flash[:notice] = "Book added!"
      redirect_to user_books_path
    else
      flash.now[:notice] = "Book could not be saved. See problems below."
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description)
  end
end
