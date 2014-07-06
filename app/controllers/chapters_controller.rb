class ChaptersController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.find(params[:book_id])
    @chapters = @book.chapters
  end

  def show
    @chapter = Chapter.find(params[:id])
  end
end
