class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :users, :points_earned, :integer
    add_column :users, :points_redeemed, :integer
  end
end