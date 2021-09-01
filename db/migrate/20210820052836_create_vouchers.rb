class CreateVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :vouchers do |t|
      t.string :code, null: false
      t.datetime :expiration_date, null: false
      t.integer :points_required, null: false, default: 0
      t.string :description
      t.integer :value
      t.boolean :active, null: false, default: true

      t.timestamps
    end
    add_index :vouchers, :code, unique: true
  end
end
