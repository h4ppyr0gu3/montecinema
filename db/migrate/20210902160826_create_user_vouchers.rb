class CreateUserVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_vouchers do |t|
      t.references :user
      t.references :voucher

      t.timestamps
    end
  end
end
