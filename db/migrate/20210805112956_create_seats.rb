class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.string :seat_number, null: false
      t.references :cinema
      t.string :seat_price, default: 0

      t.timestamps
    end
  end
end
