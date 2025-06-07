class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.references :guest, null: false, foreign_key: { to_table: :users }
      t.references :accommodation, null: false, foreign_key: true

      t.timestamps
    end

        add_index :reservations, [ :start_date, :end_date ]
        add_index :reservations, [ :accommodation_id, :start_date ]
  end
end
