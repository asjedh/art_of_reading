class Book < ActiveRecord::Base
  belongs_to :user
  has_many :chapters
  has_many :authors, through: :book_authors
  has_many :book_authors

  validates :title, presence: true
  validates :user, presence: true

end
