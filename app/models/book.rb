class Book < ActiveRecord::Base
  belongs_to :user
  has_many :chapters
  has_many :authors, through: :book_authors, autosave: true
  has_many :book_authors, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :book_authors
  accepts_nested_attributes_for :authors

  validates :title, presence: true
  validates :user, presence: true

  def add_authors_from_author_attributes(author_attr_hash)
    author_attr_hash.each do |number, author|
      add_author(self, author)
    end
  end

  private

  def add_author(book, author_info)
    book.authors << Author.find_or_initialize_by(name: author_info['name'])
  end

end
