class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.integer :role, default: 0
      t.integer :points_earned
      t.integer :points_redeemed
      t.index :email, unique: true

      t.timestamps
    end
  end
end
