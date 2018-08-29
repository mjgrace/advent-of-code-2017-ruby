class Day
  def ex_a
    distance = 0
    max_distance = 0
    x = 0
    y = 0
    z = 0
    # step_counts = {}
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      steps = split_into_steps(line)
      steps.each do |step|
        case step
        when 'n'
          y = y + 1
          z = z - 1
        when 'ne'
          x = x + 1
          z = z - 1
        when 'nw'
          x = x - 1
          y = y + 1
        when 'se'
          x = x + 1
          y = y - 1
        when 'sw'
          x = x - 1
          z = z + 1
        when 's'
          y = y - 1
          z = z + 1
        end
        distance = (x.abs + y.abs + z.abs) / 2
        max_distance = [distance, max_distance].max
      end
    end
    puts "Ex A: # of Steps - #{distance}; Ex B: Max # of steps - #{max_distance}"
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

  def split_into_steps(l)
    l.gsub("\s+", " ").split(/,/)
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
# puts Day.ex_b