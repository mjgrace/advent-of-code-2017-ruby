class Day
  def ex_a
    data = get_file_data("data.txt")
    steps = 0
    i = 0
    data = data.split("\n")
    while i < data.count do
      steps = steps + 1
      old_i = i
      # puts "#{i} #{data[i]}"
      i += data[i].to_i
      data[old_i] = data[old_i].to_i + 1
    end
    steps
  end

  def ex_b
    data = get_file_data("data.txt")
    steps = 0
    i = 0
    data = data.split("\n")
    while i < data.count do
      steps = steps + 1
      old_i = i
      # puts "#{i} #{data[i]}"
      i += data[i].to_i
      if data[old_i].to_i >= 3
        data[old_i] = data[old_i].to_i - 1
      else
        data[old_i] = data[old_i].to_i + 1
      end
    end
    steps
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
end

day = Day.new

puts day.ex_a
puts day.ex_b