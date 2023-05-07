class RemoveIndexFromChapters < ActiveRecord::Migration[7.0]
  def change
    remove_index :completions, name: "index_chapters_on_book_id"
  end
end
