class CosmeticBag
  attr_accessor :cosmetics, :owner

  def initialize(cosmetics, owner)
    @cosmetics = cosmetics
    @owner = owner
  end

  def current_worth
    "Current worth: #{cosmetics.map(&:current_price).reduce(&:+)}$"
  end

  def current_weight
    "Current weight: #{cosmetics.map(&:weight).reduce(&:+)}g"
  end

  def display_cosmetics
    cosmetics.each { |cosmetic| puts cosmetic }
  end
end

class Person < Struct.new(:name, :age)
end

class Cosmetic
  attr_accessor :name, :original_price, :original_weight, :weight, :weight_per_usage

  def initialize(name:, original_price:, original_weight:, weight_per_usage:)
    @name = name
    @original_price = original_price
    @original_weight = original_weight
    @weight = original_weight
    @weight_per_usage = weight_per_usage
  end

  def to_s
    "#{name} - price: #{original_price_for_display} (#{current_price_for_display}); " +
        "weight: #{original_weight_for_display} (#{current_weight_for_display})"
  end

  def current_price
    (weight * original_price / original_weight).round(2)
  end

  def original_price_for_display
    format("%.2f$", original_price)
  end

  def current_price_for_display
    format("%.2f$", current_price)
  end

  def original_weight_for_display
    "#{original_weight}g"
  end

  def current_weight_for_display
    "#{weight}g"
  end

  def use
    @weight -= weight_per_usage
    puts "There is #{weight}g left."
  end
end

lotion = Cosmetic.new(name: "The Body Shop balm", original_price: 10, original_weight: 200, weight_per_usage: 5)
face_mask = Cosmetic.new(name: "Organique algae mask", original_price: 3.5, original_weight: 30, weight_per_usage: 2)
face_cream = Cosmetic.new(name: "Clinique even better", original_price: 40, original_weight: 50, weight_per_usage: 1)
shower_gel = Cosmetic.new(name: "Pat&Rub", original_price: 7.5, original_weight: 280, weight_per_usage: 4)
shave_gel = Cosmetic.new(name: "L'occitan gel", original_price: 10, original_weight: 150, weight_per_usage: 1)
after_shave_balm = Cosmetic.new(name: "L'occitan balm", original_price: 18, original_weight: 75, weight_per_usage: 1)

person_1 = Person.new(name: "Irek", age: 32)
person_2 = Person.new(name: "Monika", age: 28)

bag_1 = CosmeticBag.new([shower_gel, shave_gel, after_shave_balm], person_1)
bag_2 = CosmeticBag.new([shower_gel, lotion, face_mask, face_cream], person_2)

puts bag_1.current_weight
puts bag_1.current_worth
puts "______________________"
bag_1.cosmetics[0].use
bag_1.cosmetics[0].use
bag_1.cosmetics[2].use
bag_1.cosmetics[1].use
puts "______________________"
puts bag_1.current_weight
puts bag_1.current_worth
puts "______________________"
puts "IREK'S COSMETIC BAG:"
bag_1.display_cosmetics
puts "MONIKA'S COSMETIC BAG:"
bag_2.display_cosmetics
