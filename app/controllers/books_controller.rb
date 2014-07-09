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

    if params[:book][:authors_attributes]
      params[:book][:authors_attributes].each do |number, author|
        add_author(@book, author)
      end
    end

    if @book.save
      flash[:notice] = "Book added!"
      redirect_to book_chapters_path(@book)
    else
      flash.now[:notice] = "Book could not be saved. See problems below."
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :year) #, authors_attributes: [:id, :name])
  end

  def add_author(book, author_hash)
    book.authors << Author.find_or_initialize_by(name: author_hash['name'])
  end
end
