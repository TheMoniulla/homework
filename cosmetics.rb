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

  def initialize(name, original_price, original_weight, weight_per_usage)
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

lotion = Cosmetic.new("The Body Shop balm", 10, 200, 5)
face_mask = Cosmetic.new("Organique algae mask", 3.5, 30, 2)
face_cream = Cosmetic.new("Clinique even better", 40, 50, 1)
shower_gel = Cosmetic.new("Pat&Rub", 7.5, 280, 4)
shave_gel = Cosmetic.new("L'occitan gel", 10, 150, 1)
after_shave_balm = Cosmetic.new("L'occitan balm", 18, 75, 1)

person_1 = Person.new("Irek", 32)
person_2 = Person.new("Monika", 28)

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
