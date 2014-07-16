class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:all_books_index]

  def all_books_index
    if params[:search]
      if params[:search_type] == "title"
        @all_books = Book.where("title ILIKE ?", "%#{params[:search]}%")
      elsif params[:search_type] == "isbn"
        @all_books = Book.where("isbn_10 LIKE ? OR isbn_13 LIKE ?",
          params[:search], params[:search])
      elsif params[:search_type] == "author"
        @all_books = []
        authors = Author.where("name ILIKE ?", "%#{params[:search]}%")
        authors.each do |author|
          author.books.each { |book| @all_books << book }
        end
      end
    else
      @all_books = Book.order("created_at DESC")
    end
  end

  def index
    @user = current_user
    @books = @user.books
  end

  def new
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @user = current_user
    @book.user = @user
    add_authors_from_author_attributes(@book, params[:book][:authors_attributes])

    if @book.save
      flash[:notice] = "Book added!"
      redirect_to book_chapters_path(@book)
    else
      flash.now[:notice] = "Book could not be saved. See problems below."
      render :new
    end
  end

### GOODREADS METHODS

  def goodreads_search
    goodreads_client = Goodreads::Client.new
    search = goodreads_client.search_books(params[:search])
    @results_to_display_on_view = parse_goodreads_search(search)
  end

  def goodreads_create
    goodreads_client = Goodreads::Client.new
    goodreads_book = goodreads_client.book(params[:goodreads_book_id])

    book = create_book_with_book_info(goodreads_book)

    if book.save
      redirect_to book_chapters_path(book.id)
    else
      flash[:notice] = "Sorry! There was an error."
      render 'goodreads_search'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :publication_year)
  end

  #these methods are used when user adds book manually
  def add_authors_from_author_attributes(book, author_attr_hash)
    author_attr_hash.each do |number, author|
      add_author(book, author)
    end
  end

  def add_author(book, author_info)
    book.authors << Author.find_or_initialize_by(name: author_info['name'])
  end

  #these methods are for when the goodreads search by id is used
  def create_book_with_book_info(goodreads_book)
    book_info_hash = get_book_info_hash(goodreads_book)
    book = Book.new(book_info_hash)
    book.user = current_user
    book.authors = create_authors_from_goodreads_book(goodreads_book)
    book
  end

  def get_book_info_hash(goodreads_book)
    {
      title: goodreads_book.title,
      goodreads_book_id: goodreads_book.id,
      isbn_10: goodreads_book.isbn,
      isbn_13: goodreads_book.isbn13
    }
  end

  def create_authors_from_goodreads_book(goodreads_book)
    authors = []
    goodreads_book.authors.values.each do |author|
      author_to_add = Author.find_or_initialize_by(goodreads_author_id: author.id)
      author_to_add.name = author.name
      authors << author_to_add
    end
    authors
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
