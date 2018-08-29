class Day

  def ex_a
    programs = ('a'..'p').to_a
    data = get_file_data("data.txt")
    steps = split_into_steps(data)

    steps.each do |step|
      command, args = [step[0], step[1..-1]]
      case command
      when "x"
        # puts "Before x #{args} - #{programs.join("")}"
        src, dest = args.split("/")
        programs[src.to_i], programs[dest.to_i] = programs[dest.to_i], programs[src.to_i]
        # puts "After x #{args} - #{programs.join("")}"
      when "p"
        # puts "Before p #{args} - #{programs.join("")}"
        src, dest = args.split("/")
        # programs[programs.index(src)], programs[programs.index(dest)] = programs[programs.index(dest)], programs[programs.index(src)]        
        src_index = programs.index(src)
        dest_index = programs.index(dest)
        temp = programs[src_index]
        programs[src_index] = programs[dest_index]
        programs[dest_index] = temp
        # puts "After p #{args} - #{programs.join("")}"
      when "s"
        # puts "Before s #{args} - #{programs.join("")}"
        programs = programs.rotate(-1 * args.to_i)
        # puts "After s #{args} - #{programs.join("")}"
      end
    end

    puts "Ex. A - #{programs.join("")}"
  end

  def ex_b
    dance_results = {}
    cycle_length = 0
    count = 0
    programs = ('a'..'p').to_a.join("")
    data = get_file_data("data.txt")
    steps = split_into_steps(data)

    while count < 1000000000
      puts "#{count}" if (count % 10000) == 0
      if !dance_results[programs]
        result = dance(programs, steps)
        dance_results[programs] = result
      end
      programs = dance_results[programs]
      count = count + 1
      if programs == ('a'..'p').to_a.join("")
        cycle_length = count
        puts "Found a cycle - cycle_length is #{cycle_length}"
        count = (1000000000 / cycle_length).floor * cycle_length
        puts "Count is now #{count}"
      end
    end

    puts "Ex. B - #{programs}"
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

  def dance(input, steps)
    input_array = input.split("")
    steps.each do |step|
      command, args = [step[0], step[1..-1]]
      case command
      when "x"
        # puts "Before x #{args} - #{input_array.join("")}"
        src, dest = args.split("/")
        input_array[src.to_i], input_array[dest.to_i] = input_array[dest.to_i], input_array[src.to_i]
        # puts "After x #{args} - #{input_array.join("")}"
      when "p"
        # puts "Before p #{args} - #{input_array.join("")}"
        src, dest = args.split("/")
        # input_array[input_array.index(src)], input_array[input_array.index(dest)] = input_array[input_array.index(dest)], input_array[input_array.index(src)]        
        src_index = input_array.index(src)
        dest_index = input_array.index(dest)
        temp = input_array[src_index]
        input_array[src_index] = input_array[dest_index]
        input_array[dest_index] = temp
        # puts "After p #{args} - #{input_array.join("")}"
      when "s"
        # puts "Before s #{args} - #{input_array.join("")}"
        input_array = input_array.rotate(-1 * args.to_i)
        # puts "After s #{args} - #{input_array.join("")}"
      end
    end
    return input_array.join("")
  end
end

day = Day.new

puts day.ex_a
puts day.ex_b