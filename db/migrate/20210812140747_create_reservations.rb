class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :screening
      t.references :cinema
      t.references :movie
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
