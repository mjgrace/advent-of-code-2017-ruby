

class Day
  def ex_a
    list = (0..255).to_a
    position = 0
    skip_size = 0
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      lengths = split_into_numbers(line)
      lengths.each do |length|
        sublist = []
        # puts length
        # puts "#{list}"
        (0..(length.to_i-1)).each do |i|
          sublist << list[(position.to_i + i)%list.length]
        end
        sublist.reverse!
        (0..(length.to_i-1)).each do |i|
          list[(position.to_i + i)%list.length] = sublist[i] 
        end
        # puts "#{list}"
        position += length.to_i + skip_size.to_i
        skip_size += 1
      end
    end
    puts "Ex A: Product of first two numbers is #{list[0]*list[1]}"
  end

  def ex_b
    list = (0..255).to_a
    position = 0
    skip_size = 0
    dense_hash = []
    knot_hash = ""
    data = get_file_data("data.txt")
    data.split("\n").each do |line|
      puts "#{line}"
      ascii_codes = split_into_chars(line)
      puts "#{ascii_codes}"
      ascii_codes = ascii_codes.map { |c| c.ord }
      puts "#{ascii_codes}"
      ascii_codes << [17, 31, 73, 47, 23]
      ascii_codes.flatten!
      puts "#{ascii_codes}"
      64.times do
        ascii_codes.each do |length|
        # puts "#{length}"
          sublist = []
          (0..(length.to_i-1)).each do |i|
            sublist << list[(position.to_i + i)%list.length]
          end
          sublist.reverse!
          (0..(length.to_i-1)).each do |i|
            list[(position.to_i + i)%list.length] = sublist[i] 
          end
          position += length.to_i + skip_size.to_i
          skip_size += 1
        end
        # puts "#{list}"
      end
      list.each_slice(16).each do |a|
        puts "#{a}"
        dense_hash << a.reduce(:^)
      end
    end
    knot_hash = dense_hash.map { |dh| dh.to_s(16) }.map { |dh| dh.length == 1 ? "0" + dh : dh }.join("")
    puts knot_hash.length
    puts "Ex B: Knot hash is #{knot_hash}"
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
end

day = Day.new

puts day.ex_a
puts day.ex_b