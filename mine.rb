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
    trips.map { |trip| trip_with_caption(trip) }.join("\n")
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
    groups.map { |group| group.people.length * ticket_price }.reduce(&:+)
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

class Person < Struct.new(:name)
  def to_s
    name
  end
end

person_1 = Person.new("Eric")
person_2 = Person.new("Monica")
person_3 = Person.new("Simon")
person_4 = Person.new("Matthew")
person_5 = Person.new("Isabel")
person_6 = Person.new("Ann")
person_7 = Person.new("Maggie")
person_8 = Person.new("Aggie")
person_9 = Person.new("Sofia")
person_10 = Person.new("Tom")
person_11 = Person.new("Alice")
person_12 = Person.new("Barbara")
person_13 = Person.new("Martha")
person_14 = Person.new("Jennifer")
person_15 = Person.new("Justin")
person_16 = Person.new("Joanne")

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
