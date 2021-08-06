# frozen_string_literal: true

class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.string :seat_number
      t.integer :cinema_number
      t.string :seat_price

      t.timestamps
    end
  end
end
