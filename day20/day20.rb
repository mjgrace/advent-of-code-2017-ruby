class Point
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
end

class Particle
  attr_accessor :position, :velocity, :acceleration, :alive

  def initialize(position, velocity, acceleration)
    @position = position
    @velocity = velocity
    @acceleration = acceleration
    @alive = true
  end

  def move
    if @alive
      @velocity.x = @velocity.x.to_i + @acceleration.x.to_i
      @velocity.y = @velocity.y.to_i + @acceleration.y.to_i
      @velocity.z = @velocity.z.to_i + @acceleration.z.to_i
      @position.x = @position.x.to_i + @velocity.x.to_i
      @position.y = @position.y.to_i + @velocity.y.to_i
      @position.z = @position.z.to_i + @velocity.z.to_i
    end
  end

  def manhattan_distance
    @position.x.to_i.abs + @position.y.to_i.abs + @position.z.to_i.abs
  end

  def collide?(particle)
    # if @position.x == particle.position.x && @position.y == particle.position.y && @position.z == particle.position.z    
    #   puts "#{@position.x} - #{particle.position.x} - #{@position.y} - #{particle.position.y} - #{@position.z} - #{particle.position.z}"
    # end
    @position.x == particle.position.x && @position.y == particle.position.y && @position.z == particle.position.z
  end
end

class Day

  def ex_a
    particles = []
    step_num = 0
    closest_particle = 0

    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      match_data = /p=<([-\d]+),([-\d]+),([-\d]+)>, v=<([-\d]+),([-\d]+),([-\d]+)>, a=<([-\d]+),([-\d]+),([-\d]+)>/.match(line)
      particles << Particle.new(Point.new(match_data[1], match_data[2], match_data[3]), Point.new(match_data[4], match_data[5], match_data[6]), Point.new(match_data[7], match_data[8], match_data[9]))
    end

    while step_num < 10000
      puts "#{step_num} - #{particles.select { |p| p.alive }.count}"
      particles.each(&:move)
      particles.each_with_index do |p, i|
        next if !p.alive
        closest_particle = i if p.manhattan_distance < particles[closest_particle].manhattan_distance
        particles.each_with_index do |op, j|
          if i != j and p.collide?(op)
            p.alive = false
            op.alive = false
          end
        end
      end
      step_num = step_num + 1
    end
    puts "Ex. A - Closest particle over time is #{closest_particle}; Ex. B - # of alive particles is #{particles.select { |p| p.alive }.count}"
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