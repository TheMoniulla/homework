class Truck
  attr_accessor :height, :depth, :width, :packs

  def initialize(height:, depth:, width:)
    @height = height
    @depth = depth
    @width = width
    @packs = []
  end

  def add_pack(pack)
    if check_dimensions(pack)
      @packs.push(pack)
      @height -= pack.height
      # @width -= pack.width
      # @depth -= pack.depth
      puts "#{pack} is loaded."
    else
      puts "There isn't enough space for #{pack}"
    end
  end

  def check_dimensions(pack)
    pack.height <= height
  end
end

class Pack
  attr_accessor :id, :height, :depth, :width

  def to_s
   "Pack ##{id}"
  end

  def initialize(id:, height:, depth:, width:)
    @id = id
    @height = height
    # @depth = depth
    # @width = width
  end
end

pack_1 = Pack.new(id: 1, height: 80, depth: 50, width: 60)
pack_2 = Pack.new(id: 2, height: 60, depth: 40, width: 40)
pack_3 = Pack.new(id: 3, height: 160, depth: 40, width: 40)
pack_4 = Pack.new(id: 4, height: 110, depth: 60, width: 40)
truck = Truck.new(height: 250, depth: 300, width: 150)

truck.add_pack(pack_1)
truck.add_pack(pack_2)
truck.add_pack(pack_3)
truck.add_pack(pack_4)
