class ChangeBooksTable < ActiveRecord::Migration
  def change
    remove_column :books, :description, :string

    add_column :books, :goodreads_book_id, :integer
    add_column :books, :orig_pub_year, :integer
    add_column :books, :isbn_10, :string
    add_column :books, :isbn_13, :string
  end
end
