class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:all_books_index]

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
    @book.authors.build
  end

  def create
    @book = Book.new(book_params)
    @user = current_user
    @book.user = @user

    if @book.save

      params[:book][:authors_attributes].each do |number, author_info|
        author = Author.find_or_create_by(name: author_info['name'])
        BookAuthor.create(author: author, book: @book)
      end
      flash[:notice] = "Book added!"
      redirect_to book_chapters_path(@book)
    else
      flash.now[:notice] = "Book could not be saved. See problems below."
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :year) #, authors_attributes: [:id, :name] )
  end
end
