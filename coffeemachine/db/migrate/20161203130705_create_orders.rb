class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.float :order_sum
      t.belongs_to :user, index: true
      t.belongs_to :drink, index: true

      t.datetime :performed
      t.timestamps
    end

    create_table :ingredients_orders, id: false do |t|
      t.belongs_to :order, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end
