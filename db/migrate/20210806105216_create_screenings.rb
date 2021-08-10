# frozen_string_literal: true

class CreateScreenings < ActiveRecord::Migration[6.1]
  def change
    create_table :screenings do |t|
      t.references :cinema
      t.references :movie, null: false, foreign_key: true
      t.integer :additional_cost, default: 0
      t.datetime :airing_time, null: false
      t.integer :seats_available
      t.timestamps
    end
  end
end
