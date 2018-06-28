class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.integer :start_time
      t.integer :end_time
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
