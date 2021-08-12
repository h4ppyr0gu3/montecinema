# frozen_string_literal: true

class CreateCinemas < ActiveRecord::Migration[6.1]
  def change
    create_table :cinemas do |t|
      t.integer :cinema_number
      t.integer :total_seats
      t.timestamps
    end
  end
end
