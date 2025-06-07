class CreateAccommodations < ActiveRecord::Migration[8.0]
  def change
    create_table :accommodations do |t|
      t.integer :available_beds, null: false
      t.integer :price, null: false
      t.string :description, null: false
      t.boolean :has_wifi, null: false, default: true
      t.text :welcome_message, null: false

      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end

    add_index :accommodations, :price
    add_index :accommodations, :available_beds
    add_index :accommodations, :has_wifi
    add_index :accommodations, [ :city_id, :price ]
  end
end
