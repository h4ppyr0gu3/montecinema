class CreateJtis < ActiveRecord::Migration[6.1]
  def change
    create_table :jtis do |t|
      t.string :jti, unique: true, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
