class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :screening
      t.references :cinema

      t.timestamps
    end
  end
end
