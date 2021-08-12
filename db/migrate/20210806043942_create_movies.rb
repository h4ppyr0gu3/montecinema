class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.integer :length, null: false
      t.text :description, null: false
      t.string :director, null: false
      t.string :genre, null: false
      t.timestamps
    end
  end
end
