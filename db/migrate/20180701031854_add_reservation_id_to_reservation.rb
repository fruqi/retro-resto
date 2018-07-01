class AddReservationIdToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :reservation_id, :bigint
  end
end
