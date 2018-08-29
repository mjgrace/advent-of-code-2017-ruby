class Day
  def ex_a
    data = get_file_data("data.txt")
    checksum = 0
    data.split("\n").each do |line|
      line = split_into_nums(line)
      line = line.sort_by(&:to_i)
      max_val = line[-1].to_i
      min_val = line[0].to_i
      checksum += (max_val - min_val)
    end
    checksum
  end

  def ex_b
    data = get_file_data("data.txt")
    checksum = 0
    data.split("\n").each do |line|
      nums = split_into_nums(line)
      nums.each do |num1|
        nums.each do |num2|
          checksum += (num1.to_i / num2.to_i) if ((num1.to_i % num2.to_i) == 0 and num1 != num2)
        end
      end
    end
    checksum
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_nums(l)
    l.gsub("\s+"," ").split(" ")
  end
end

day = Day.new

puts day.ex_a
puts day.ex_b