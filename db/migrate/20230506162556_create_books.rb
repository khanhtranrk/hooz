class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :other_names, default: ''
      t.string :author, default: ''
      t.text :description, default: ''
      t.integer :views, default: 0
      t.integer :favorites, default: 0
      t.boolean :active, default: false
      t.boolean :free, default: false

      t.timestamps
    end
  end
end
