class User < ApplicationRecord
  has_many :orders

  validates_presence_of :name
  validates_presence_of :password

  def order(sum)
    self.money_left -= sum
    save
  end

  def self.authenticate (name,password)
    user = find_by_name(name)
    puts name
    if user && user.password == password
      user
    else
      nil
    end
  end
end
