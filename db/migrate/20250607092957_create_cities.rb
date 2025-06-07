class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :zip_code

      t.timestamps
    end
    add_index :cities, :name, unique: true
    add_index :cities, :zip_code, unique: true
  end
end
