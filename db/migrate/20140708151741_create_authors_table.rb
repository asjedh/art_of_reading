class CreateAuthorsTable < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.integer :goodreads_author_id
    end
  end
end
