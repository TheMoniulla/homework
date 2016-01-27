class Truck
  attr_accessor :name, :height, :depth, :width, :packages

  def initialize(name:, height:, depth:, width:)
    @name = name
    @height = height
    @depth = depth
    @width = width
    @packages = []
  end

  def to_s
    "#{name} includes packages: #{packages.join(", ")}"
  end

  def add_package(package)
    if check_dimensions(package)
      @packages.push(package)
      @depth -= package.depth
      package.status = "loaded"
      puts "#{package} is loaded."
    else
      puts "There isn't enough space for #{package}"
    end
  end

  def check_dimensions(package)
    package.height < height && package.depth < depth
  end
end

class Package
  attr_accessor :id, :height, :depth, :width, :status

  def to_s
    "Package ##{id}"
  end

  def initialize(id:, height:, depth:, width:)
    @id = id
    @height = height
    @depth = depth
    @width = width
    @status = ""
  end
end

class Distribution
  attr_accessor :trucks, :packages

  def initialize(trucks, packages)
    @trucks = trucks
    @packages = packages
  end

  def for_display
    "#{loaded_trucks}\nNot loaded packages: #{not_loaded_packages}"
  end

  def loaded_trucks
    trucks.join("\n")
  end

  def not_loaded_packages
    packages.select { |pack| pack.status != "loaded" }.join(", ")
  end

  def ordered_by_height(array)
    array.sort! { |x, y| y.height <=> x.height }
  end

  def distribute_packages
    trucks.each do |truck|
      packages.each do |pack|
        truck.add_package(pack) if pack.status != "loaded"
      end
    end
  end
end

truck_1 = Truck.new(name: "Scania", height: 250, depth: 300, width: 150)
truck_2 = Truck.new(name: "Magnum", height: 300, depth: 200, width: 140)
truck_3 = Truck.new(name: "Fiat", height: 180, depth: 250, width: 100)

package_1 = Package.new(id: 1, height: 80, depth: 50, width: 60)
package_2 = Package.new(id: 2, height: 60, depth: 40, width: 40)
package_3 = Package.new(id: 3, height: 160, depth: 40, width: 40)
package_4 = Package.new(id: 4, height: 80, depth: 50, width: 60)
package_5 = Package.new(id: 5, height: 260, depth: 80, width: 130)
package_6 = Package.new(id: 6, height: 140, depth: 70, width: 120)
package_7 = Package.new(id: 7, height: 280, depth: 160, width: 80)
package_8 = Package.new(id: 8, height: 190, depth: 60, width: 40)

distribution = Distribution.new([truck_1, truck_2, truck_3],
                                [package_1, package_2, package_3, package_4, package_5, package_6, package_7, package_8])

distribution.ordered_by_height(distribution.trucks)
distribution.ordered_by_height(distribution.packages)

distribution.distribute_packages
puts '--------------------------------------------------------------'
puts distribution.for_display
