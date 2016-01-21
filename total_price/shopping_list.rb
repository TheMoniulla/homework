require_relative 'total_price'
require_relative 'product'

class ShoppingList
  include TotalPrice
  attr_accessor :products

  def initialize
    @products = []
  end

  def to_s
    "Shopping list:\n#{products.join("\n")}\n#{total_price_for_display}"
  end

  def add_product(product)
    @products.push(product)
  end

  def total_price_for_display
    "Total price: #{total_price(products)}$"
  end
end

my_shopping_list = ShoppingList.new
product_1 = Product.new(name: 'LINDOR Pillow Assorted', price: 10)
product_2 = Product.new(name: 'LINDOR Pillow Milk', price: 10)
product_3 = Product.new(name: 'LINDT Swiss Luxury Selection', price: 12)

my_shopping_list.add_product(product_1)
my_shopping_list.add_product(product_2)
my_shopping_list.add_product(product_3)
puts my_shopping_list
