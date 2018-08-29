class Day

  def ex_a
    picosecond = 0
    packet_index = -1
    severity = 0
    firewall_layers = []
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      layer, range = split_into_numbers(line)
      firewall_layers[layer.to_i] = Array.new(range.to_i)
    end
    while packet_index < firewall_layers.length
      packet_index = packet_index + 1
      if firewall_blocked(firewall_layers, packet_index, picosecond)
        severity = severity + (packet_index * firewall_layers[packet_index].length)
        puts "Blocked on #{packet_index} at #{picosecond} - new severity is #{severity}"
        if !firewall_layers[packet_index].nil?
          puts "Firewall length for #{packet_index} is #{firewall_layers[packet_index].length} - Firewall for #{packet_index} is at #{(picosecond % ((firewall_layers[packet_index].length - 1)*2))}"
        end
      else
        # puts "Not blocked on #{packet_index} at #{picosecond}"
        if !firewall_layers[packet_index].nil?
          # puts "Firewall length is #{firewall_layers[packet_index].length} - Firewall for #{packet_index} is at #{(picosecond % ((firewall_layers[packet_index].length - 1)*2))}"
        end
      end
      picosecond = picosecond + 1
    end
    puts "Ex A: Severity - #{severity}"
  end

  def ex_b
    picosecond = 0
    packet_index = -1
    severity = 0
    firewall_layers = []
    delay = 0
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      layer, range = split_into_numbers(line)
      firewall_layers[layer.to_i] = Array.new(range.to_i)
    end
    while packet_index < firewall_layers.length
      packet_index = packet_index + 1
      # puts "Checking #{packet_index} at #{picosecond + delay}"
      if firewall_blocked(firewall_layers, packet_index, picosecond + delay)
        # puts "Blocked on #{packet_index} at #{picosecond + delay} - resetting"
        delay = delay + 1
        picosecond = 0
        packet_index = -1
      else
        # puts "Not blocked on #{packet_index} at #{picosecond + delay}"
        picosecond = picosecond + 1
      end
    end
    puts "Ex B: Min Delay - #{delay}"
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_numbers(l)
    l.gsub("\s+", " ").split(/:/)
  end

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def split_into_chars(l)
    l.split("")
  end

  def firewall_blocked(firewall_layers, index, picosecond)
    return false if firewall_layers[index].nil?
    (picosecond % ((firewall_layers[index].length - 1)*2)) == 0
  end
end

day = Day.new

puts day.ex_a
puts day.ex_b