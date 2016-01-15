class Atm
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end

  def authenticate(card)
    card_authentication(card)
    if card.blocked
      puts "The card is blocked"
    else
      if card.phone
        mobile_authentication(card)
        if card.blocked
          puts "The card is blocked"
        end
      else
        menu(card)
      end
    end
  end

  private

  def card_authentication(card)
    3.times do
      puts 'Enter PIN'
      pin = gets.chomp
      if card.pin == pin
        return true
      else
        puts 'wrong pin'
      end
    end
    card.block!
  end

  def mobile_authentication(card)
    3.times do
      puts 'Enter MOBILE PIN'
      mobile_pin = gets.chomp
      if mobile_pin == card.phone.pin
        menu(card)
        return true
      else
        puts 'wrong mobile pin'
      end
    end
    card.block!
  end

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
        menu(card)
    end
  end

  def show_account_balance(card)
    puts "You have: #{card.balance}$"
  end

  def withdraw_money(card)
    puts 'How much do you want to withdraw?'
    money = gets.chomp.to_i

    if card.balance < money
      puts "You don't have enough money."
    elsif balance < money
      puts "There is not enough money in ATM."
    else
      @balance -= money
      card_balance = card.balance - money
      puts "Your account balance: #{card_balance}$"
      puts "ATM balance: #{balance}$"
    end
  end

  def add_money(card)
    puts 'How much do you want to add?'
    money = gets.chomp.to_i

    @balance += money
    card_balance = card.balance + money
    puts "Your account balance: #{card_balance}$"
    puts "ATM balance: #{balance}$"
  end
end

class Card
  attr_reader :pin, :account, :phone, :blocked

  def initialize(pin:, account:, phone:)
    @pin = pin
    @account = account
    @phone = phone
    @blocked = false
  end

  def balance
    account.balance
  end

  def balance=(value)
    account.balance += value
  end

  def block!
    @blocked = true
  end
end

class Account < Struct.new(:balance)
end

class Phone < Struct.new(:pin)
end

account = Account.new(100)
phone = Phone.new('4321')
card = Card.new(pin: '1234', account: account, phone: phone)
Atm.new(10000).authenticate(card)
