class ChaptersController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.find(params[:book_id])
    @chapters = @book.chapters
    @chapter = Chapter.new
  end

  def show
    @chapter = Chapter.find(params[:id])
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @book = Book.find(params[:book_id])
    @chapter.book_id = params[:book_id]

    if @chapter.save
      flash[:notice] = "Your chapter has been added."
      redirect_to book_chapters_path(@chapter.book_id)
    else
      flash.now[:notice] = "You're chapter could not be added. See errors below."
      @book = Book.find(params[:book_id])
      @chapters = @book.chapters
      render 'chapters/index'
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :summary, :tldr, :reflection, :key_concepts)
  end
end
