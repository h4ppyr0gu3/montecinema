class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.belongs_to :seat, null: false
      t.belongs_to :reservation, null: false

      t.timestamps
    end
  end
end
