class Product
  attr_accessor :name, :price

  def to_s
    "#{name}: #{price}$"
  end

  def initialize(name:, price:)
    @name = name
    @price = price
  end
end
