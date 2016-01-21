module TotalPrice
  def total_price(products)
    products.map(&:price).reduce(&:+)
  end
end
