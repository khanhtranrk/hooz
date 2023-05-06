class CreateRegisteries < ActiveRecord::Migration[7.0]
  def change
    create_table :registeries do |t|
      t.string :key, null: false
      t.jsonb :value, null: false
    end

    add_index :registeries, :key, unique: true
  end
end
