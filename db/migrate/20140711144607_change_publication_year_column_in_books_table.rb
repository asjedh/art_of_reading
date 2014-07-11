class ChangePublicationYearColumnInBooksTable < ActiveRecord::Migration
  def change
    remove_column :books, :orig_pub_year, :integer
    add_column :books, :publication_year, :integer
  end
end
