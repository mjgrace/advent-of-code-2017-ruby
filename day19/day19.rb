class Day

  def ex_a
    @maze = []
    @x = 0
    @y = 0
    @direction = "down"
    @letters = ""
    @step_count = 0
    
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      @maze << line.chars
    end
    
    @x = @maze[0].index("|")
    @step_count = @step_count + 1
    # while !end_of_path(@maze, @y, @x, @direction)
    while !end_of_path
      # y, x, direction, letters = step(maze, y, x, direction, letters)
      # step(@maze, y, x, direction, letters)
      step
  end
    puts "Ex. A - #{@letters}; Ex. B - #{@step_count}"
  end

  def ex_b
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

  # def step(maze, y, x, direction, letters)
  def step
      puts "#{@y} - #{@x}"
    case @direction
    when "down"
      @y = @y + 1
    when "up"
      @y = @y - 1
    when "left"
      @x = @x - 1
    when "right"
      @x = @x + 1
    end
    puts "Now #{@y} - #{@x} - #{@maze[@y][@x]}"
    if @maze[@y][@x] == "+"
      if @maze[@y-1] and (@maze[@y-1][@x] == "|" or @maze[@y-1][@x] =~ /[A-Z]/) and @direction != "down"
        @direction = "up"
      elsif @maze[@y+1] and (@maze[@y+1][@x] == "|" or @maze[@y+1][@x] =~ /[A-Z]/) and @direction != "up"
        @direction = "down"
      elsif @maze[@y][@x-1] and (@maze[@y][@x-1] == "-" or @maze[@y][@x-1] =~ /[A-Z]/) and @direction != "right"
        @direction = "left"
      elsif @maze[@y][@x+1] and (@maze[@y][@x+1] == "-" or @maze[@y][@x+1] =~ /[A-Z]/) and @direction != "left"
        @direction = "right"
      end
    end
    if @maze[@y][@x] =~ /[A-Z]/
      @letters = @letters + @maze[@y][@x]
    end
    @step_count = @step_count + 1
  end

  def end_of_path
    return false if @maze[@y][@x] == "+"
    case @direction
    when "down"
      @maze[@y+1] and @maze[@y+1][@x] == " "
    when "up"
      @maze[@y-1] and @maze[@y-1][@x] == " "
    when "left"
      @maze[@y][@x-1] and @maze[@y][@x-1] == " "
    when "right"
      @maze[@y][@x+1] and @maze[@y][@x+1] == " "
    end
  end
end

day = Day.new

puts day.ex_a
# puts Day.ex_b