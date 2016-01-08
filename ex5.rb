class PrimePalindrome
  attr_accessor :numbers

  def initialize(numbers)
    @numbers = numbers
  end

  def to_s
    numbers.select do |number|
      is_prime_palindrome?(number)
    end.max
  end

  def is_prime_palindrome?(number)
    is_palindrome?(number) && is_prime?(number)
  end

  def is_palindrome?(num)
    num.to_s == num.to_s.reverse
  end

  def is_prime?(number)
    arr = (2..number).select do |num|
      number % num == 0
    end
    arr.length == 1
  end
end

numbers = (1..1000)
puts PrimePalindrome.new(numbers).to_s
