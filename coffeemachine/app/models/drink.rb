class Drink < ApplicationRecord

  def order
    self.amount_left -= 1
    save
  end
end
