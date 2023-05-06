class CreateBookCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :book_categories do |t|
      t.bigint :book_id, null: false
      t.bigint :category_id, null: false
    end

    add_index :book_categories, [:book_id, :category_id], unique: true
  end
end
