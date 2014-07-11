class Book < ActiveRecord::Base
  belongs_to :user
  has_many :chapters
  has_many :authors, through: :book_authors, autosave: true
  has_many :book_authors, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :book_authors
  accepts_nested_attributes_for :authors

  validates :title, presence: true
  validates :user, presence: true

end
