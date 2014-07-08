class ChangeBooksTable < ActiveRecord::Migration
  def change
    remove_column :books, :description, :string

    add_column :books, :goodreads_id, :integer
    add_column :books, :orig_pub_year, :integer
  end
end
