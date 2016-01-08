class Atm
  attr_accessor :balance, :file

  def initialize(balance)
    @balance = balance
  end

  def authenticate(card)
    puts 'Enter PIN'
    pin = gets.chomp
    if card.pin == pin
      menu(card)
    else
      puts 'wrong pin number'
    end
  end

  private

  def menu(card)
    puts '1 - show account balance'
    puts '2 - withdraw money'
    puts '3 - add money'

    case gets.chomp
      when '1'
        show_account_balance(card)
      when '2'
        withdraw_money(card)
      when '3'
        add_money(card)
      else
        puts 'wrong input'
    end
  end

  def show_account_balance(card)
    puts "You have: #{card.account.balance}$"
  end

  def withdraw_money(card)
    puts 'How much do you want to withdraw?'
    money = gets.chomp.to_i

    if card.account.balance < money
      puts "You don't have enough money."
    elsif balance < money
      puts "There is not enough money in ATM."
    else
      @balance -= money
      card.account.balance -= money
      puts "Your account balance: #{card.account.balance}$"
      puts "ATM balance: #{balance}$"
    end
  end

  def add_money(card)
    puts 'How much do you want to add?'
    money = gets.chomp.to_i

    @balance += money
    card.account.balance += money
    puts "Your account balance: #{card.account.balance}$"
    puts "ATM balance: #{balance}$"
  end
end

class Card
  attr_accessor :pin, :account

  def initialize(pin, account)
    @pin = pin
    @account = account
  end
end

class Account
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end
end

account = Account.new(100)
card = Card.new('1234', account)
Atm.new(10000).authenticate(card)
