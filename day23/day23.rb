require 'prime'

class CommandProcessor
  attr_accessor :mul_count, :registers

  def initialize(thread_index)
    @registers = {}
    @last_sound_value = 0
    @commands = []
    @command_index = 0
    @thread_index = thread_index
    @to_sound_count = 0
    @mul_count = 0

    @registers["a"] = 1

    @data = get_file_data("data.txt")
    @commands = @data.split("\n")
  end

  def process_commands
    while @command_index < @commands.length
      command = @commands[@command_index]
      process_command
    end
  end

  def process_command
    command = @commands[@command_index]
    instruction, val1, val2 = command.split(" ")
    val2 = @registers[val2].to_i if val2 =~ /[a-z]/

    case instruction
    # when "snd"
    #   @last_sound_value = @registers[val1]
    #   # puts "Thread #{thread_index} - Sending #{registers[val1]}"
    #   to_sounds.push(@registers[val1])
    #   @to_sound_count = @to_sound_count.to_i + 1
    when "set"
      @registers[val1] = val2.to_i
    when "add"
      @registers[val1] = @registers[val1].to_i + val2.to_i
    when "mul"
      @mul_count = @mul_count + 1
      @registers[val1] = @registers[val1].to_i * val2.to_i
    when "mod"
      @registers[val1] = @registers[val1].to_i % val2.to_i
    when "sub"
      @registers[val1] = @registers[val1].to_i - val2.to_i
    # when "rcv"
    #   puts "Last sound value is #{@last_sound_value}" if @registers[val1].to_i > 0
    #   while from_sounds.length == 0
    #     puts "Thread #{@thread_index} - Waiting for a value"
    #     puts "Thread #{@thread_index} has sent #{@to_sound_count} values"
    #     sleep 1 
    #   end
    #   if from_sounds.length > 0
    #     @registers[val1] = from_sounds.shift
    #   end
    when "jnz"
      # puts "#{thread_index} - Command index is #{command_index} - register #{val1} is #{registers[val1].to_i}"
      if @registers[val1].to_i != 0 or (val1 =~ /[\-0-9]+/ and val1.to_i != 0)
        @command_index = @command_index + val2.to_i
      else
        @command_index = @command_index + 1
      end
      # puts "#{thread_index} - Command index is #{command_index} - register #{val1} is #{registers[val1].to_i}"
    end
    @command_index = @command_index + 1 if instruction != "jnz"
    # puts registers
  end  

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end
end

class Day

  def ex_a
    cp = CommandProcessor.new(0)
    cp.process_commands
    puts "Multiply count - #{cp.mul_count}"
  end

  def ex_b
    cp = CommandProcessor.new(0)
    cp.registers['h'] = 0
    # cp.process_commands
    (105700..122700).step(17) do |n|
      cp.registers['h'] = cp.registers['h'] + 1 if !Prime.prime?(n)
    end
    puts "Register H Value - #{cp.registers['h']}"
  end
end

day = Day.new

# puts day.ex_a
puts day.ex_b