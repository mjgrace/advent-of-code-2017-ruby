class Day
  def ex_a
    data = get_file_data("data.txt")
    count = 0
    data.split("\n").each do |line|
      line = split_into_words(line)
      count = count + 1 if line.count == line.group_by { |w| w }.count
    end
    count
  end

  def ex_b
    data = get_file_data("data.txt")
    count = 0
    data.split("\n").each do |line|
      line = split_into_words(line)
      line = line.map! { |w| w.chars.sort.join }
      count = count + 1 if line.count == line.group_by { |w| w }.count
    end
    count
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