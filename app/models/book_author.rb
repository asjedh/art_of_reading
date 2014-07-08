class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
  accepts_nested_attributes_for :author

  validates :book, presence: true
  validates :author, presence: true
end
