module Day
  def ex_a
    @programs = []
    program_chains = []
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      program, junk, subprograms = line.split(" ", 3)
      @programs[program.to_i] = []
      @programs[program.to_i] << subprograms.split(",").map { |s| s.strip }
      @programs[program.to_i].flatten!
    end
    for i in 0..@programs.length-1
      # TODO - Fix new program chains
      if program_chains.select { |chain| chain.include? i }.count == 0
        new_program_chain = []
        new_program_chain = program_list(i, new_program_chain)
        program_chains << new_program_chain
      end
    end
    program_chain_0 = program_chains.select { |chain| chain.include? 0 }.first
    puts "Ex A: # of Programs for 0 - #{program_chain_0.length}; Ex B: # of Program Chains - #{program_chains.length}"
  end

  def ex_b
    # In Ex A
  end

  def get_file_data(filename)
    data = nil
    open(filename) { |f|
      data = f.read
    }
    return data
  end

  def split_into_numbers(l)
    l.gsub("\s+", " ").split(/,/)
  end

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def split_into_chars(l)
    l.split("")
  end

  def program_list(program, program_list)
    puts "#{program} - #{program_list}"
    program_list << program if program and !program_list.include?(program)
    @programs[program].each do |s|
      next if program_list.include?(s.to_i)
      program_list = program_list(s.to_i, program_list)
    end
    # puts "#{program_list.flatten}"
    return program_list
  end
end

include Day

puts Day.ex_a
# puts Day.ex_b