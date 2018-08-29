class Day
  def ex_a
    data = get_file_data("data.txt")
    data.split("").select.with_index { |a, i| data[i] == data[(i+1)%data.length] }.inject(0) { |sum,x| sum + x.to_i }
  end

  def ex_b
    data = get_file_data("data.txt")
    data.split("").select.with_index { |a, i| data[i] == data[(i+(data.length/2))%data.length] }.inject(0) { |sum,x| sum + x.to_i }
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end
end

day = Day.new
puts day.ex_a
puts day.ex_b