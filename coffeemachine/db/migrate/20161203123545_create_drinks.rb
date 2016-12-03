class CreateDrinks < ActiveRecord::Migration[5.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.integer :amount_left
      t.float :price

      t.timestamps
    end
  end
end
