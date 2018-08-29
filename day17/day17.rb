class Day

  def ex_a
    spinlock = ['0']
    cycle_length = 329
    index = 0
    count = 1
    
    # puts "#{spinlock.join(",")}"
    while count <= 2017
      index = cycle(spinlock.length, index, cycle_length)
      index = index + 1
      spinlock.insert(index, count)
      # puts "#{spinlock.join(",")}"
      count = count + 1
    end

    puts "Ex. A - #{spinlock[index+1]}"
  end

  def ex_b

    # TODO - Just keep track

    spinlock_length = 1
    cycle_length = 329
    index = 0
    count = 1
    num_after_zero = 0
    
    # puts "#{spinlock.join(",")}"
    while count <= 50000000
      puts "#{count}" if count % 1000000 == 0
      index = cycle(spinlock_length, index, cycle_length)
      index = index + 1
      spinlock_length = spinlock_length + 1
      if index == 1
        num_after_zero = count
      end
      count = count + 1
    end

    puts "Ex. B - #{num_after_zero}"
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_steps(l)
    l.gsub("\s+", " ").split(/,/)
  end

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def split_into_chars(l)
    l.split("")
  end

  def cycle(spinlock_length, index, cycle_length)
    index = (index + cycle_length) % spinlock_length
    return index
  end
end

day = Day.new

puts day.ex_a
puts day.ex_b