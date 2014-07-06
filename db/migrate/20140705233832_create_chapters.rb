class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title, null: false
      t.integer :book_id, null: false
      t.string :summary
      t.string :tldr
      t.string :key_concepts
      t.string :reflection

      t.timestamps
    end

  add_index :chapters, :book_id
  end
end
