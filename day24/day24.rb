Port = Struct.new(:a, :b)

class Day

  def initialize
    @ports = []
    @bridges = []
    @max_strength = 0
    @strength_longest = 0
    @max_length = 0
    @data = get_file_data("data.txt").split("\n")
    @data.each do |line|
      a, b = split_into_numbers(line)
      @ports << Port.new(a, b)
    end
  end

  def ex_a
    @ports.select { |port| port.a.to_i == 0 or port.b.to_i == 0 }.each do |port|
      bridge = []
      # port.disabled = true
      bridge << port
      @bridges << bridge
    end
    while @bridges.length > 0
      bridge = @bridges.shift

      # Figure out which port to use
      port_num = if bridge.length > 1
        (bridge[-2].b.to_i == bridge[-1].b.to_i || bridge[-2].a.to_i == bridge[-1].b.to_i) ? bridge[-1].a.to_i : bridge[-1].b.to_i
      else
        0 == bridge[-1].b.to_i ? bridge[-1].a.to_i : bridge[-1].b.to_i
      end

      ports = @ports.select { |port| port.a.to_i == port_num or port.b.to_i == port_num and !bridge.find { |p| p == port } }

      ports.each do |port|
        new_bridge = Array.new(bridge)
        # puts "#{bridge_strength(new_bridge)} - Bridge #{new_bridge} - Found port #{port}"
        new_bridge << port
        # puts "Added bridge #{new_bridge.join}"
        @bridges << new_bridge
        # puts "Bridges is ", @bridges.map { |bridge| puts "Bridge: #{bridge}" }
        if new_bridge.length > @max_length or (new_bridge.length == @max_length and bridge_strength(new_bridge) > @strength_longest)
          @max_length = new_bridge.length
          @strength_longest = bridge_strength(new_bridge)
        end
        @max_strength = bridge_strength(new_bridge) if bridge_strength(new_bridge) > @max_strength
      end
    end

    puts "Max strength is #{@max_strength}"
    puts "Strength of longest is #{@strength_longest}"
  end

  def ex_b
  end

  def bridge_strength(bridge)
    bridge.reduce(0) { |sum, obj| sum + obj.a.to_i + obj.b.to_i }
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_numbers(l)
    l.gsub("\s+", " ").split(/\//)
  end

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def split_into_chars(l)
    l.split("")
  end
end

day = Day.new

puts day.ex_a
# puts day.ex_b