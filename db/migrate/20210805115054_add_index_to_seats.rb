class AddIndexToSeats < ActiveRecord::Migration[6.1]
  def change
    add_index :seats, [:seat_number, :cinema_number], unique: true
  end
end
