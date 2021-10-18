class RemoveCityFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :city, :string
  end
end
