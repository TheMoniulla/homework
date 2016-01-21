require_relative 'total_price'
require_relative 'product'

class Shop
  include TotalPrice
  attr_accessor :list, :cart

  def initialize
    @list = []
    @cart = []
  end

  def add_products(products)
    products.each { |product| @list.push(product) }
  end

  def add_product_to_cart(product)
    if list.include?(product)
      @cart.push(product)
      @list.delete(product)
      puts "#{product} was added to cart"
    else
      puts "Product is not available"
    end
  end

  def remove_product_from_cart(product)
    if cart.include?(product)
      @cart.delete(product)
      @list.push(product)
      puts "#{product} was removed from cart"
    else
      puts "Product is not in the cart"
    end
  end

  def cart_for_display
    puts '------------CART--------------'
    cart.each { |p| puts p }
    puts '------------TOTAL-------------'
    puts "#{total_cart_price}$"
    puts '------------------------------'
  end

  def total_cart_price
    total_price(cart)
  end
end



product_1 = Product.new(name: 'LINDOR Pillow Assorted', price: 10)
product_2 = Product.new(name: 'LINDOR Pillow Milk', price: 10)
product_3 = Product.new(name: 'LINDOR Maxi Ball Milk', price: 5)
product_4 = Product.new(name: 'LINDOR Cornet Extra Dark', price: 9)
product_5 = Product.new(name: 'LINDT Mini Pralinés', price: 6)
product_6 = Product.new(name: 'LINDT Swiss Luxury Selection', price: 12)

shop = Shop.new
shop.add_products([product_1, product_2, product_3, product_4, product_5, product_6])
shop.add_product_to_cart(product_2)
shop.add_product_to_cart(product_2)
shop.add_product_to_cart(product_3)
shop.add_product_to_cart(product_4)
shop.add_product_to_cart(product_5)
shop.remove_product_from_cart(product_2)
puts shop.cart
shop.cart_for_display
