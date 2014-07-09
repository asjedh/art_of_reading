class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
  accepts_nested_attributes_for :author
end
