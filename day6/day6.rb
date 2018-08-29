Program = Struct.new(:program, :weight, :subprograms)

class Day
  def ex_a
    programs = []
    data = get_file_data("data.txt")
    matches = {}
    count = 0
    recycle = 0
    nums = split_into_words(data)
    nums.map! { |n| n.to_i }
    while !matches[nums.join(" ")]
      # puts nums.join(" ")
      count = count + 1
      matches[nums.join(" ")] = 1
      max_index = nums.index(nums.max)
      max_bank = nums[max_index]
      # puts max_index
      # puts max_bank
      nums[max_index] = 0
      # puts nums.join(" ")
      while max_bank > 0 do
        max_index = (max_index + 1) % nums.count
        nums[max_index] = nums[max_index] + 1
        max_bank = max_bank - 1
      end
      # puts nums.join(" ")
    end
    count
  end

  def ex_b
    data = get_file_data("data.txt")
    matches = {}
    count = 0
    recycle = 0
    nums = split_into_words(data)
    nums.map! { |n| n.to_i }
    while !(matches[nums.join(" ")] == 2)
      # puts nums.join(" ")
      count = count + 1
      matches[nums.join(" ")] = matches[nums.join(" ")] ? matches[nums.join(" ")] + 1 : 1
      recycle = recycle + 1 if matches[nums.join(" ")] > 1
      max_index = nums.index(nums.max)
      max_bank = nums[max_index]
      # puts max_index
      # puts max_bank
      nums[max_index] = 0
      # puts nums.join(" ")
      while max_bank > 0 do
        max_index = (max_index + 1) % nums.count
        nums[max_index] = nums[max_index] + 1
        max_bank = max_bank - 1
      end
      # puts nums.join(" ")
    end
    recycle
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