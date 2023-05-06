class CreateReadingChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :reading_chapters do |t|
      t.bigint :user_id, null: false
      t.bigint :book_id, null: false
      t.bigint :chapter_id, null: false

      t.timestamps
    end

    add_index :reading_chapters, [:user_id, :book_id], unique: true
  end
end
