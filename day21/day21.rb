class Day

  def initialize
    @rules = {}
    @data = []
    @num_runs = 18
  end

  def ex_a
    # Read rules
    read_rules
    # Read start pattern
    read_start_pattern
    # Loop # of times
    @num_runs.times do |i|
      puts "Run #{i}"
      if @data[0].length % 2 == 0
        puts "Divisible by 2"
        loop_through_array(2, 2)
      else
        puts "Divisible by 3"
        loop_through_array(3, 3)
      end
    end

    number_on
  end

  def ex_b
  end

  def read_rules
    data = get_file_data("data.txt")
    data = data.split("\n")
    data.each do |line|
      from, to = line.split "=>"
      from = from.strip.split "/"
      to = to.strip.split "/"
      @rules[from] = to
    end
  end

  def read_start_pattern
    data = get_file_data("startpattern.txt")
    @data = data.split("\n")
  end

  def subarray(array, start_row, rows, start_col, columns)
    array[start_row..(start_row+rows-1)].map { |row| row[start_col..(start_col+columns-1)] }    
  end

  def flip_array_horizontal(array)
    flip_array = []
    array.each_with_index { |row, i| flip_array[i] = array[i].reverse }
    return flip_array
  end

  def flip_array_vertical(array)
    flip_array = []
    row = 0
    while row < array.length
      flip_array[row] = array[array.length - 1 - row]
      row = row + 1
    end
    return flip_array
  end

  def rotate_array(array, turns = 1)
    rotated_array = array.dup
    turns.times do
      temp_array = Array.new(array[0].length) { Array.new(array.length) }
      row = 0
      while row < rotated_array.length
        col = 0
        while col < rotated_array[row].length
          temp_array[col][rotated_array.length - 1 - row] = rotated_array[row][col]
          col = col + 1
        end
        row = row + 1
      end
      rotated_array = temp_array.map { |row| row.join }
    end
    return rotated_array
  end

  def loop_through_array(row_step_size, col_step_size)
    start_row = 0
    while start_row < @data.length
      start_col = 0
      while start_col < @data[start_row].length
        subarray = subarray(@data, start_row, row_step_size, start_col, col_step_size)
        subarrays = generate_array_combos(subarray)
        if rule = find_matching_rule(subarrays)
          replace_matching_rule(start_row, start_col, rule, @rules[rule])
        else
          puts "No match found"
        end
        start_col = start_col + col_step_size + 1
      end
      start_row = start_row + row_step_size + 1
    end
  end

  def generate_array_combos(subarray)
    subarrays = []
    4.times do
      subarrays << subarray
      subarrays << flip_array_horizontal(subarray)
      subarrays << flip_array_vertical(subarray)
      subarrays << flip_array_vertical(flip_array_horizontal(subarray))
      subarray = rotate_array(subarray)
    end
    return subarrays
  end

  def find_matching_rule(subarrays)
    @rules.each do |from, to|
      subarrays.each do |subarray|
        next if from.length != subarray[0].length
        if rule_matches(from, subarray)
          return from
        end
      end
    end
    # No matches - return nil
    return nil
  end

  def rule_matches(rule, array)
    row = 0
    while row < rule.length
      return false if rule[row] != array[row]
      row = row + 1
    end
    return true
  end

  def replace_matching_rule(start_row, start_col, from, to)
    row = 0
    @data.insert(start_row+from.length, Array.new(to.length, " ").join) if start_col == 0
    while row < to.length
      @data[start_row+row][start_col..start_col+to[row].length-2] = to[row]
      row = row + 1
    end
  end

  def number_on
    @data.join.chars.select { |c| c == '#' }.count
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_points(l)
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