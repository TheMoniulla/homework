class Factor
  attr_accessor :text, :years

  def initialize(text, years)
    @text = text
    @years = years
  end
end

class Person
  attr_accessor :name, :age, :factor_years

  STANDARD_LIFESPAN = 105.0

  def initialize(name:, age:, factor_years:)
    @name = name
    @age = age
    @factor_years = factor_years
  end

  def to_s
    "#{personal_data_for_display}\n#{factors_for_display}"
  end

  private

  def expected_lifespan
    STANDARD_LIFESPAN + factor_years.map(&:lifespan_change).reduce(&:+).round(2)
  end

  def factors_for_display
    factor_years.map { |factor_year| factor_year }.join("\n")
  end

  def personal_data_for_display
    "#{name}, #{age} years old - expected_lifespan: #{expected_lifespan}"
  end
end

class FactorYears < Struct.new(:factor, :years)
  def lifespan_change
    (factor.years * years / Person::STANDARD_LIFESPAN).round(2)
  end

  def to_s
    "- #{factor.text} for #{years}: #{lifespan_change} years"
  end
end

factor_1 = Factor.new("alcohol", -40)
factor_2 = Factor.new("smoking", -30)
factor_3 = Factor.new("drugs", -70)

factor_4 = Factor.new("exercises", 20)
factor_5 = Factor.new("low-fat diet", 10)
factor_6 = Factor.new("life in the village", 30)

person_1 = Person.new(name: "George", age: 30, factor_years: [FactorYears.new(factor_1, 5),
                                                              FactorYears.new(factor_2, 2),
                                                              FactorYears.new(factor_4, 10)])

person_2 = Person.new(name: "Abraham", age: 90, factor_years: [FactorYears.new(factor_1, 40),
                                                               FactorYears.new(factor_2, 70),
                                                               FactorYears.new(factor_4, 13),
                                                               FactorYears.new(factor_6, 90)])

person_3 = Person.new(name: "Lucy", age: 39, factor_years: [FactorYears.new(factor_1, 21),
                                                            FactorYears.new(factor_2, 25),
                                                            FactorYears.new(factor_3, 22),
                                                            FactorYears.new(factor_5, 23)])
puts person_1
puts '---------------------'
puts person_2
puts '---------------------'
puts person_3
