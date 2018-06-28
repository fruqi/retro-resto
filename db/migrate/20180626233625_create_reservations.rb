class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :guest_count
      t.datetime :reservation_time
      t.references :restaurant, foreign_key: true
      t.references :guest, foreign_key: true

      t.timestamps
    end
  end
end
