

class Day
  
  def ex_a
    registers = {}
    max_register_value = 0
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      words = split_into_words(line)
      # puts "checking #{words[0]} - #{check_register(registers[words[4]], words[5], words[6])}"
      registers[words[0]] = inc_dec(registers[words[0]], words[1], words[2]) if check_register(registers[words[4]], words[5], words[6])
      # puts "New value of #{words[0]} is #{registers[words[0]]}"
      max_register_value = registers.values.max if registers.values.max > max_register_value
    end
    puts "Ex A: #{registers.values.max} - Ex B: #{max_register_value}"
  end

  def ex_b
    # In Ex A
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def inc_dec(register, inc_dec, value)
    case inc_dec
    when 'inc'
      register = register.to_i + value.to_i
    when 'dec'
      register = register.to_i - value.to_i
    end
    register
  end

  def check_register(register, check, value)
    case check
    when '=='
      register.to_i == value.to_i
    when '!='
      register.to_i != value.to_i
    when '>'
      register.to_i > value.to_i
    when '>='
      register.to_i >= value.to_i
    when '<'
      register.to_i < value.to_i
    when '<='
      register.to_i <= value.to_i
    end
  end

end

day = Day.new

puts day.ex_a
# puts Day.ex_b