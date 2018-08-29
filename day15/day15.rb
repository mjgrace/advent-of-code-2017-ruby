class Day

  def ex_a
    @generators = {}
    match_total = 0
    @generators['A'] = 516
    @generators['B'] = 190

    40000000.times do |i|
      get_next_generators_result("A")
      get_next_generators_result("B")
      # puts "Generator A is #{generators['A']}; Generator B is #{generators['B']}"
      if last_16_binary(@generators['A']) == last_16_binary(@generators['B'])
        match_total = match_total + 1
      end
    end

    puts "Ex. A - Match Total is #{match_total}"
  end

  def ex_b
    @generators = {}
    match_total = 0
    @generators['A'] = 516
    @generators['B'] = 190

    5000000.times do |i|
      get_next_generators_result("A", 4)
      get_next_generators_result("B", 8)
      # puts "Generator A is #{generators['A']}; Generator B is #{generators['B']}"
      if last_16_binary(@generators['A']) == last_16_binary(@generators['B'])
        match_total = match_total + 1
      end
    end

    puts "Ex. B - Match Total is #{match_total}"
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

  def get_next_generators_result(name, mod = 1)
    if name == "A"
      loop do
        @generators["A"] = @generators["A"] * 16807 % 2147483647
        if (@generators["A"] % mod) == 0
          break
        end
      end
    end
    if name == "B"
      loop do
        @generators["B"] = @generators["B"] * 48271 % 2147483647
        if (@generators["B"] % mod) == 0
          break
        end
      end
    end
  end

  def last_16_binary(num)
    return num.to_s(2).rjust(32,"0").slice(16, 16)
  end

end

day = Day.new

puts day.ex_a
puts day.ex_b