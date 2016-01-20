class CarWash
  attr_accessor :card, :programs, :selected_programs

  def initialize
    wash = Program.new(id: 1, name: 'Wash', price: 5, timer: 4)
    rinse = Program.new(id: 2, name: 'Rinse', price: 2, timer: 3)
    wax = Program.new(id: 3, name: 'Wax', price: 3, timer: 2)
    shine = Program.new(id: 4, name: 'Shine', price: 4, timer: 1)
    @programs = [wash, rinse, wax, shine]
    @selected_programs = []
  end

  def wash(card)
    @card = card
    menu
  end

  private

  def menu_for_display
    (programs - selected_programs).each do |program|
      puts "#{program.id} - #{program.name} (#{program.price}$)"
    end
  end

  def menu
    puts 'Choose program'
    menu_for_display
    puts "5 - That's all"
    case gets.chomp
      when '1'
        @selected_programs.push(programs[0])
        menu
      when '2'
        @selected_programs.push(programs[1])
        menu
      when '3'
        @selected_programs.push(programs[2])
        menu
      when '4'
        @selected_programs.push(programs[3])
        menu
      when '5'
        if selected_programs.include?(programs[0]) && selected_programs.include?(programs[1])
          check_balance(total_price, total_time)
        else
          puts "You must select Wash & Rinse!"
          menu
        end
      else
        puts 'wrong input'
        menu
    end
  end

  def total_price
    selected_programs.map(&:price).reduce(&:+)
  end

  def total_time
    selected_programs.map(&:timer).reduce(&:+)
  end

  def check_balance(price, time)
    if card.balance >= price
      card.balance -= price
      puts 'You can drive in.'
      loading(time)
      puts "Your car is ready :)"
    else
      puts 'Not enough cash on your credit card'
    end
  end

  def loading(int)
    int.times do
      sleep(1)
      print('.')
    end
    puts "\n"
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

class Program
  attr_reader :id, :name, :price, :timer

  def initialize(id:, name:, price:, timer:)
    @id = id
    @name = name
    @price = price
    @timer = timer
  end
end

card_1 = CreditCard.new(owner: "Irek", balance: 10)
washing_1 = CarWash.new
washing_1.wash(card_1)
