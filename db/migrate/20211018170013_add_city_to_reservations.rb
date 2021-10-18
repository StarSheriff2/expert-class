class AddCityToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :city, null: false, foreign_key: true
  end
end
