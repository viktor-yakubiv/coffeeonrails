class Order < ApplicationRecord
  belongs_to :user
  belongs_to :drink
  has_and_belongs_to_many :ingredients
end
