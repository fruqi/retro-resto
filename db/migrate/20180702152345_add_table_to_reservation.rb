class AddTableToReservation < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :table, foreign_key: true
  end
end
