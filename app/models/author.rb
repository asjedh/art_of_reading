class Author < ActiveRecord::Base
  has_many :books, through: :book_authors
  has_many :book_authors

  validates :name, presence: true
end
