class CarWash
  def wash(card)
    menu(card)
  end

  private

  def menu(card)
    puts 'Choose program'
    puts '1 - Wash and Rinse (5$)'
    puts '2 - Wash, Rinse and Shine (6$)'
    puts '3 - Wash, Rinse and Wax (7$)'
    puts '4 - Wash, Rinse, Shine and Wax (8$)'

    case gets.chomp
      when '1'
        check_balance(card, 5, 3)
      when '2'
        check_balance(card, 6, 4)
      when '3'
        check_balance(card, 7, 5)
      when '4'
        check_balance(card, 8, 6)
      else
        puts 'wrong input'
        menu(card)
    end
  end

  def check_balance(card, price, time)
    if card.balance > price
      card.balance -= price
      puts 'You can drive in.'
      sleep(time)
      puts "Your car is ready :)"
    else
      puts 'Not enough cash on your credit card'
    end
  end
end

class CreditCard
  attr_accessor :balance
  attr_reader :owner

  def initialize(owner:, balance:)
    @owner = owner
    @balance = balance
  end

end

card_1 = CreditCard.new(owner: "Irek", balance: 6)
washing_1 = CarWash.new
washing_1.wash(card_1)
