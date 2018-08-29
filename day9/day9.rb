

class Day
  def ex_a
    @score = 0
    @garbage_count = 0
    
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      line = throw_out_bangs(line)
      line = throw_out_garbage(line)
      score_line(line)
    end
    puts "Ex A: Score is #{@score}, Ex B: Garbage count is #{@garbage_count}"
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

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def throw_out_bangs(line)
    line.gsub(/!./, '')
  end

  def throw_out_garbage(line)
    @garbage_count = line.scan(/<([^>]*)>/).flatten.sum{ |g| g.length }
    line = line.gsub(/<[^>]*>/, '')
    return line
  end

  def score_line(line)
    @score = 0
    bracket_score = 0
    chars = line.split ""
    chars.each do |c|
      if c == '{'
        bracket_score += 1
      elsif c == '}'
        @score += bracket_score
        bracket_score -= 1
      end
    end
  end
end

day = Day.new

puts day.ex_a
# puts Day.ex_b