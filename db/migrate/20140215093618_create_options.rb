class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :symbol
      t.date :expiration
      t.string :type
      t.float :strike
      t.float :last
      t.float :bid
      t.float :ask
      t.integer :vol
      t.integer :open_int

      t.timestamps
    end
  end
end
