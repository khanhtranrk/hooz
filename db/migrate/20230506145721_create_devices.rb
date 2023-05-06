class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.bigint :session_id, null: false
      t.string :exponent_token, null: false

      t.timestamps
    end

    add_index :devices, :session_id, unique: true
    add_index :devices, :exponent_token, unique: true
  end
end
