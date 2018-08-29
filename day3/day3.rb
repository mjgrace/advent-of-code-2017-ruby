# This works but would be nice to refactor someday.
# I like how the spiral is generated but adding the sum_neighbors/return 
# for Part B is not as clean as I would like.

class Day
  def ex_a
    data = get_file_data("data.txt").strip.to_i
    spiral, val = generate_spiral(data)
    # print_spiral(spiral)
    calculate_distance(data,1,spiral)
  end

  def ex_b
    data = get_file_data("data.txt").strip.to_i
    spiral, first_val = generate_spiral(data, true)
    # print_spiral(spiral)
    first_val
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def generate_spiral(count, sum_neighbors = false)
    max_rows = 10000
    max_cols = 10000
    spiral = Array.new(max_rows) { Array.new(max_cols) }
    row = spiral.count / 2
    col = spiral[row].count / 2
    val = 1
    index = 1
    spiral[row][col] = val
    col = col + 1
    if sum_neighbors
      index = index + 1
      val = sum_neighbors(spiral, row, col)
    else
      index = index + 1
      val = val + 1
    end
    spiral[row][col] = val
    return spiral, val if val > count
    while val<=count and row < max_rows do
      # Go up
      while spiral[row][col - 1] do
        row = row - 1
        if sum_neighbors
          index = index + 1
          val = sum_neighbors(spiral, row, col)
        else
          index = index + 1
          val = val + 1
        end
        spiral[row][col] = val
        return spiral, val if val > count
      end

      # Go left
      while spiral[row + 1][col] do
        col = col - 1
        if sum_neighbors
          index = index + 1
          val = sum_neighbors(spiral, row, col)
        else
          index = index + 1
          val = val + 1
        end
        spiral[row][col] = val
        return spiral, val if val > count
      end

      # Go down
      while spiral[row][col + 1] do
        row = row + 1
        if sum_neighbors
          index = index + 1
          val = sum_neighbors(spiral, row, col)
        else
          index = index + 1
          val = val + 1
        end
        spiral[row][col] = val
        return spiral, val if val > count
      end

      # Go right
      while spiral[row - 1][col] do
        col = col + 1
        if sum_neighbors
          index = index + 1
          val = sum_neighbors(spiral, row, col)
        else
          index = index + 1
          val = val + 1
        end
        spiral[row][col] = val
        return spiral, val if val > count
      end
    end
    return spiral, 0
  end

  def print_spiral(spiral)
    puts"====="
    spiral.each do |row|
      row.each do |element|
        print "#{element}\t"
      end
      print "\n"
    end
    puts"====="
  end

  def calculate_distance(from,to,spiral)
    from_row, from_col = find_element(from, spiral)
    to_row, to_col = find_element(to, spiral)
    (to_row - from_row).abs + (to_col - from_col).abs
  end

  def find_element(element, spiral)
    spiral.each_with_index do |row, i|
      return [i, row.index(element)] if row.index(element)
    end
    return [nil,nil]
  end

  def sum_neighbors(spiral, row, col)
    sum = 0
    (row-1..row+1).each do |row_index|
      (col-1..col+1).each do |col_index|
        sum = sum + spiral[row_index][col_index].to_i
      end
    end
    sum
  end
end

day = Day.new

puts day.ex_a
puts day.ex_b