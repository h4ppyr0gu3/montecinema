class CreateRedeemables < ActiveRecord::Migration[6.1]
  def change
    create_table :redeemables do |t|
      t.references :user
      t.references :voucher
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
