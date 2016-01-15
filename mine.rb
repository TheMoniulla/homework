class Mine
  attr_accessor :trips

  def initialize
    @trips = [Trip.new(hour: '08:00', ticket_price: 12),
              Trip.new(hour: '10:00', ticket_price: 20),
              Trip.new(hour: '12:00', ticket_price: 20),
              Trip.new(hour: '14:00', ticket_price: 20)]
  end

  def to_s
    "#{trips_for_display}\n#{day_revenue_for_display}"
  end

  private

  def trips_for_display
    trips.map { |trip| "#{trip_with_caption(trip)}\n#{trip.statistic_for_display}\n" }.join("\n")
  end

  def trip_with_caption(trip)
    "HOUR #{trip.hour}\n#{trip}"
  end

  def day_revenue_for_display
    "DAY REVENUE: #{day_revenue}$"
  end

  def day_revenue
    trips.map(&:revenue).compact.reduce(&:+)
  end
end

class Trip
  attr_accessor :hour, :ticket_price, :groups

  def initialize(hour:, ticket_price:)
    @hour = hour
    @ticket_price = ticket_price
    @groups = []
  end

  def add_group(group)
    if groups.size < 3
      groups.push(group)
      puts "#{group} added to the trip :)"
    else
      puts '*** This trip is full! ***'
    end
  end

  def revenue
    groups.map do |group|
      group.people.map do |person|
        ticket_price_with_discount(person.age).round(2)
      end
    end.flatten.reduce(&:+)
  end

  def ticket_price_with_discount(age)
    case age
      when 0..5 then
        0
      when 6..17 then
        0.5 * ticket_price
      when 18..64 then
        ticket_price
      else
        0.3 * ticket_price
    end
  end

  def statistic_for_display
    if trip_size
      "  Trip size: #{trip_size} people with average age #{average_age} years old (#{people_per_age})"
    else
      '  No clients = No statistics :/'
    end
  end

  def trip_size
    groups.map { |group| group.people.size }.reduce(&:+)
  end

  def people_per_age
    all_people = groups.map { |group| group.people }.flatten
    result = {"0-5" => 0, "6-17" => 0, "18-64" => 0, "65+" => 0}
    all_people.each do |person|
      case person.age
        when 0..5 then
          result["0-5"] += 1
        when 6..17 then
          result["6-17"] += 1
        when 18..64 then
          result["18-64"] += 1
        else
          result["65+"] += 1
      end
    end
    result.map { |key, val| "#{key}: #{val}" }.join(", ")
  end

  def average_age
    groups.map { |group| group.people}.flatten.map(&:age).reduce(&:+) / trip_size
  end

  def to_s
    if groups.empty?
      "  No groups for this hour :("
    else
      groups.map { |group| "  #{group}" }.join("\n")
    end
  end
end

class Group
  attr_accessor :people

  def initialize
    @people = []
  end

  def add_person(person)
    if people.size < 5
      people.push(person)
      puts "#{person} added to the group :)"
    else
      puts '*** This group is full ***'
    end
  end

  def to_s
    "Group: [#{people.join(', ')}]"
  end
end

class Person
  attr_reader :name, :age

  def initialize(name:, age:)
    @name = name
    @age = age
  end

  def to_s
    "#{name} (age: #{age})"
  end
end

person_1 = Person.new(name: "Eric", age: 10)
person_2 = Person.new(name: "Monica", age: 11)
person_3 = Person.new(name: "Simon", age: 10)
person_4 = Person.new(name: "Matthew", age: 11)
person_5 = Person.new(name: "Isabel", age: 25)
person_6 = Person.new(name: "Ann", age: 65)
person_7 = Person.new(name: "Maggie", age: 66)
person_8 = Person.new(name: "Aggie", age: 67)
person_9 = Person.new(name: "Sofia", age: 4)
person_10 = Person.new(name: "Tom", age: 29)
person_11 = Person.new(name: "Alice", age: 28)
person_12 = Person.new(name: "Barbara", age: 15)
person_13 = Person.new(name: "Martha", age: 16)
person_14 = Person.new(name: "Jennifer", age: 17)
person_15 = Person.new(name: "Justin", age: 18)
person_16 = Person.new(name: "Joanne", age: 19)

group_1 = Group.new
group_1.add_person(person_1)
group_1.add_person(person_2)
group_1.add_person(person_3)
group_1.add_person(person_4)
group_1.add_person(person_5)
group_1.add_person(person_6)

group_2 = Group.new
group_2.add_person(person_6)
group_2.add_person(person_7)
group_2.add_person(person_8)

group_3 = Group.new
group_3.add_person(person_9)
group_3.add_person(person_10)
group_3.add_person(person_11)

group_4 = Group.new
group_4.add_person(person_12)
group_4.add_person(person_13)
group_4.add_person(person_14)
group_4.add_person(person_15)
group_4.add_person(person_16)

mine = Mine.new

mine.trips[0].add_group(group_1)
mine.trips[0].add_group(group_2)
mine.trips[0].add_group(group_3)
mine.trips[0].add_group(group_4)

mine.trips[1].add_group(group_4)
puts '_______________________________________________________________________'

puts mine
