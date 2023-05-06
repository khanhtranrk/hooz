class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.bigint :book_id, null: false

      t.timestamps
    end

    add_index :chapters, :book_id, unique: true
  end
end
