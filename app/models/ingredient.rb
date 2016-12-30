class Ingredient < ApplicationRecord
  has_and_belongs_to_many :orders
  def order
    self.amount_left -= 1
    save
  end
end
