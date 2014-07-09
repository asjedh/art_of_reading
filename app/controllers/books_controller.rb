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
    @book.add_authors_from_author_attributes(params[:book][:authors_attributes])

    if @book.save
      flash[:notice] = "Book added!"
      redirect_to book_chapters_path(@book)
    else
      flash.now[:notice] = "Book could not be saved. See problems below."
      render :new
    end
  end

  def goodreads_search
    goodreads_client = Goodreads::Client.new
    search = goodreads_client.search_books(params[:search])
    @results_to_display_on_view = parse_goodreads_search(search)
  end

  def goodreads_create
    goodreads_client = Goodreads::Client.new
    goodreads_book = goodreads_client.book(params[:goodreads_book_id])
    book = create_book_with_book_info(goodreads_book)

    redirect_to book_path(book.id)
  end

  private

  def book_params
    params.require(:book).permit(:title, :year)
  end

  #these methods are for when the goodreads search by id is used
  def create_book_with_book_info(goodreads_book)
    book_info_hash = get_book_info_hash(goodreads_book)
    book = Book.new(book_info_hash)
    book.user = current_user
    book.authors = assign_authors_from_goodreads(goodreads_book)
  end

  def get_book_info_hash(goodreads_book)
    {
      title: goodreads_book.title,
      goodreads_book_id: goodreads_book.id,
      isbn_10: goodreads_book.isbn,
      isbn_13: goodreads_book.isbn13
    }
  end

  #these methods are for when the goodreads search by title, author, or isbn function is used
  def parse_goodreads_search(search)
    books = []

    search.results.work.each do |book|
      books << get_book_info_from_search(book)
    end
    books
  end

  def get_book_info_from_search(book)
    {
      title: book.best_book.title,
      goodreads_book_id: book.best_book.id,
      author: book.best_book.author.name,
      goodreads_author_id: book.best_book.author.id,
      img_url: book.best_book.image_url,
      original_publication_year: book.original_publication_year
    }
  end


end
