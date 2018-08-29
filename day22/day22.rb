class Day

  def initialize
    @max_rows = 10000
    @max_cols = 10000
    # @grid = Array.new(@max_rows) { Array.new(@max_cols) }
    # @row = @grid.count / 2
    # @col = @grid[@row].count / 2
    @direction = "up"
    @infect_count = 0
    @data = get_file_data("data.txt").split("\n")
  end

  def ex_a
    add_data_to_grid
    @infect_count = 0
    @direction = "up"
    # @grid.each_with_index { |row, i| puts "#{i} - #{row.join}" }
    # puts "Row #{@row} Col #{@col} Cursor Row #{@cursor_row} Cursor Col #{@cursor_col}"
    10000.times do
      burst
    end
    puts "Ex. A: Infect count: #{@infect_count}"
    # @grid.each_with_index { |row, i| puts "#{i} - #{row.join}" }
    # puts "Row #{@row} Col #{@col} Cursor Row #{@cursor_row} Cursor Col #{@cursor_col}"
  end

  def ex_b
    add_data_to_grid
    @infect_count = 0
    @direction = "up"
    # @grid.each_with_index { |row, i| puts "#{i} - #{row.join}" }
    # 100.times do
    10000000.times do
      evolved_burst
    end
    puts "Ex. B: Infect count: #{@infect_count}"
    # @grid.each_with_index { |row, i| puts "#{i} - #{row.join}" }
    # puts "Row #{@row} Col #{@col} Cursor Row #{@cursor_row} Cursor Col #{@cursor_col}"
  end

  def add_data_to_grid
    @grid = Array.new(@max_rows) { Array.new(@max_cols) }
    @row = @grid.count / 2
    @col = @grid[@row].count / 2
    @data.each_with_index do |data_row, row_index|
      @data[row_index].chars.each_with_index do |data_col, col_index|
        @grid[@row+row_index][@col+col_index] = @data[row_index][col_index]
      end
    end
    @cursor_row = @row+@data.length / 2
    @cursor_col = @col+@data[0].length / 2
  end

  def burst
    if @grid[@cursor_row][@cursor_col] == '#'
      turn_right
      @grid[@cursor_row][@cursor_col] = '.'
    else
      turn_left
      @grid[@cursor_row][@cursor_col] = '#'
      @infect_count = @infect_count + 1
    end
    move_forward
  end

  def evolved_burst
    case @grid[@cursor_row][@cursor_col]
    when 'W'
      @grid[@cursor_row][@cursor_col] = '#'
      @infect_count = @infect_count + 1
    when '#'
      turn_right
      @grid[@cursor_row][@cursor_col] = 'F'
    when 'F'
      reverse
      @grid[@cursor_row][@cursor_col] = '.'
    else
      turn_left
      @grid[@cursor_row][@cursor_col] = 'W'
    end
    move_forward
  end

  def move_forward
    case @direction
    when "up"
      @cursor_row = @cursor_row - 1
    when "left"
      @cursor_col = @cursor_col - 1
    when "down"
      @cursor_row = @cursor_row + 1
    when "right"
      @cursor_col = @cursor_col + 1
    end
  end

  def turn_left
    @direction = case @direction
    when "up"
      "left"
    when "left"
      "down"
    when "down"
      "right"
    when "right"
      "up"
    end
  end

  def turn_right
    @direction = case @direction
    when "up"
      "right"
    when "right"
      "down"
    when "down"
      "left"
    when "left"
      "up"
    end
  end

  def reverse
    @direction = case @direction
    when "up"
      "down"
    when "right"
      "left"
    when "down"
      "up"
    when "left"
      "right"
    end
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
puts day.ex_b