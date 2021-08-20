class CreateVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :vouchers do |t|
      t.string :code 
      t.datetime :expiration_date
      t.integer :points_required

      t.timestamps
    end
  end
end
