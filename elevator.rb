class Elevator
  attr_accessor :people, :blocked, :blocked_count

  def initialize()
    @people = []
    @blocked = false
    @blocked_count = 0
  end

  def add_person(person)
    if people_count < 5
      people.push(person)
    else
      puts 'There is no enough space!'
    end
  end

  def move
    if total_weight <= 400
      puts 'Elevator moves'
    else
      puts 'Too much weight!'
      @blocked = true
      @blocked_count += 1
      if blocked_count == 3
        puts 'Elevator needs a service'
      end
    end
  end

  def remove_person(person)
    people.delete(person)
    if total_weight <= 400
      @blocked = false
    end
  end

  def service
    @people.map {|person| people.delete(person)}
    @blocked_count = 0
    @blocked = false
  end

  private

  def total_weight
    people.map(&:weight).reduce(&:+)
  end

  def people_count
    people.count
  end

end

class Person < Struct.new(:name, :weight)
end


elevator = Elevator.new
person_1 = Person.new('Irek', 73)
person_2 = Person.new('Monika', 58)
person_3 = Person.new('Anna', 48)
person_4 = Person.new('Tomasz', 71)
person_5 = Person.new('Marek', 92)
person_6 = Person.new('Paweł', 110)
person_7 = Person.new('Marcin', 85)

elevator.add_person(person_1)
elevator.add_person(person_4)
elevator.add_person(person_5)
elevator.add_person(person_6)
elevator.add_person(person_7)
elevator.move
puts '_________________________'
elevator.remove_person(person_7)
elevator.move
puts '_________________________'
elevator.add_person(person_2)
elevator.add_person(person_3)
puts '_________________________'
elevator.remove_person(person_3)
elevator.move
puts '_________________________'
elevator.remove_person(person_1)
elevator.move
puts '_________________________'
elevator.add_person(person_7)
elevator.move
puts '_________________________'
elevator.service
elevator.move

