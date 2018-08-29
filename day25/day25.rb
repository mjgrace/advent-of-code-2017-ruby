class Action
  attr_accessor :write, :move, :next_state

  def initialize(write, move, next_state)
    @write = write
    @move = move
    @next_state = next_state
  end
end

class State
  attr_accessor :actions
  
  def initialize
    @actions = []
  end
end

class Day

  def initialize
    @state = "A"
    @num_steps = 12964419
    @cursor = (@num_steps+1)/2
    @tape = Array.new(@num_steps+1, 0)

    @checksum = 0
    
    @states = {}
    @states['A'] = State.new
    @states['A'].actions[0] = Action.new(1, 1, 'B')
    @states['A'].actions[1] = Action.new(0, 1, 'F')
    @states['B'] = State.new
    @states['B'].actions[0] = Action.new(0, -1, 'B')
    @states['B'].actions[1] = Action.new(1, -1, 'C')
    @states['C'] = State.new
    @states['C'].actions[0] = Action.new(1, -1, 'D')
    @states['C'].actions[1] = Action.new(0, 1, 'C')
    @states['D'] = State.new
    @states['D'].actions[0] = Action.new(1, -1, 'E')
    @states['D'].actions[1] = Action.new(1, 1, 'A')
    @states['E'] = State.new
    @states['E'].actions[0] = Action.new(1, -1, 'F')
    @states['E'].actions[1] = Action.new(0, -1, 'D')
    @states['F'] = State.new
    @states['F'].actions[0] = Action.new(1, 1, 'A')
    @states['F'].actions[1] = Action.new(0, -1, 'E')
  end

  def ex_a

    @num_steps.times do
      @value = @tape[@cursor]
      @tape[@cursor] = @states[@state].actions[@value].write
      @cursor = @cursor + @states[@state].actions[@value].move
      @state = @states[@state].actions[@value].next_state
    end

    @checksum = @tape.sum
  end

  def ex_b
  end

  def split_into_numbers(l)
    l.gsub("\s+", " ").split(/\//)
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
# puts day.ex_b