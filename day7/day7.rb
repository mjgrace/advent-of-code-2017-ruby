Program = Struct.new(:program, :weight, :subprograms, :parent)

class Day

  @programs

  def ex_a
    @programs = []
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      words = split_into_words(line)
      weight = words[1].gsub(/\((\d+)\)/,'\1')
      subprograms = words[3..-1]
      subprograms = subprograms ? subprograms.each { |s| s.gsub!(/,/, "") } : []
      @programs << Program.new(words[0], weight, subprograms)
    end
    # Build tower
    @programs.each do |p|
      @programs.select { |s| p.subprograms.include?(s.program) }.each { |s| s.parent = p.program }
    end
    @programs.select { |p| p.parent.nil? }.each { |p| puts "#{p.program} #{p.weight} #{p.subprograms.join(' ')} #{p.parent}"}
  end

  def ex_b
    @programs = []
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      words = split_into_words(line)
      weight = words[1].gsub(/\((\d+)\)/,'\1')
      subprograms = words[3..-1]
      subprograms = subprograms ? subprograms.each { |s| s.gsub!(/,/, "") } : []
      @programs << Program.new(words[0], weight, subprograms)
    end
    # Build tower
    @programs.each do |p|
      @programs.select { |s| p.subprograms.include?(s.program) }.each { |s| s.parent = p.program }
    end
    # Find the root
    root_program = @programs.detect { |p| p.parent.nil? }
    # Go through the tower
    loop_through_tower(root_program.program)
    
    # root_program.subprograms.each do |p|
      
    #   subprogram = programs.detect { |p| p.program == p.program }
    #   next if subprogram.subprograms.count == 0
    #   next if subprogram.subprograms.map { |s| tower_weight(programs, s) }.uniq.count == 1
    #   puts "#{subprogram.program} - #{subprogram.weight} is not balanced"
    #   subprogram.subprograms.each { |s| puts "Tower weight for #{s} is " + tower_weight(programs, s).to_s }      
    # end
    # unbalanced_program = programs.detect { |p| p.program == "apjxafk" }
    # puts "#{unbalanced_program.program} - #{unbalanced_program.weight} is not balanced"
    # unbalanced_program.subprograms.each { |s| puts "Tower weight for #{s} is " + tower_weight(programs, s).to_s }
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

  def tower_weight(program_name)
    program = @programs.detect { |p| p.program == program_name }
    program.weight.to_i + program.subprograms.sum(0) { |s| tower_weight(s).to_i }
  end

  def program_balanced?(program_name)
    program = @programs.detect { |p| p.program == program_name }
    program.subprograms.count == 0 || program.subprograms.map { |s| tower_weight(s) }.uniq.count == 1
  end

  def siblings_balanced?(program_name)
    parent_program = @programs.detect { |p| p.parent == program_name }
    parent_program and (parent_program.subprograms.count == 0 || parent_program.subprograms.map { |s| tower_weight(s) }.uniq.count == 1)
  end

  def loop_through_tower(program_name)
    program = @programs.detect { |p| p.program == program_name }
    if !program.subprograms.count == 0 or !program_balanced?(program_name) or !siblings_balanced?(program_name) or program.program == "apjxafk"
      puts "#{program.program} - #{program.weight} is not balanced"
      program.subprograms.each do |s|
        puts "Tower weight for #{s} is " + tower_weight(s).to_s     
        loop_through_tower(s)
      end
    end
  end
end

day = Day.new

puts day.ex_a
puts day.ex_b