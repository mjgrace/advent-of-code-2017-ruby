class Day

  def ex_a
    disk = Array.new(128) { Array.new(128, '.') }
    total_used = 0
    region_number = 0
    # region_number_to_use = nil
    knot_hash_input = get_file_data("data.txt")
    knot_hash_input = knot_hash_input.chomp
    # puts "#{knot_hash_input}"
    disk.each_with_index do |row, row_index|
      knot_hash_key = knot_hash_input + "-" + row_index.to_s
      knot_hash = knot_hash(knot_hash_key)
      knot_hash_binary = knot_hash.chars.map { |c| c.hex.to_s(2).rjust(4,'0') }.join("")
      # puts "Knot hash binary for Row #{row_index} - #{knot_hash} - #{knot_hash_binary}"
      knot_hash_binary_chars = split_into_chars(knot_hash_binary)
      total_used = total_used + knot_hash_binary_chars.select { |c| c.to_i == 1 }.count
      disk[row_index].each_with_index do |col, col_index|
        if knot_hash_binary_chars[col_index].to_i == 1
          disk[row_index][col_index] = '#'
        end
      end
    end

    disk.each_with_index do |row, row_index|
      disk[row_index].each_with_index do |col, col_index|
        if disk[row_index][col_index].to_s == '#'
          region_number = region_number.to_i + 1
          # puts "Finding region #{region_number} at Row #{row_index}, Col #{col_index}"
          find_region(disk, region_number, row_index, col_index)
          # puts "Row #{row_index} - Col #{col_index} - Region Number #{region_number}"
          # if !region_number_to_use
          #   region_number_to_use = region_number
          # end
          # disk[row_index][col_index] = region_number_to_use
        end
      end
    end

    disk[0..127].each_with_index do |row, row_index|
      puts "#{disk[row_index][0..127].join(",")}"
    end

    puts "Ex. A - Total Used Squares #{total_used}; Ex. B - Number of regions #{region_number}"



      # puts "Knot hash for #{knot_hash_key} is #{knot_hash} - binary #{knot_hash_binary} - #{knot_hash.length}"
      #   #   # TODO - Why is the get region number not returning nil?
      #     region_number_to_use = get_region_number(disk, row_index, col_index)
      #   #   puts "Region number to use is #{region_number_to_use} - is it nil? #{region_number_to_use.nil?}"
      #     if !region_number_to_use
      #       region_number = region_number.to_i + 1
      #       region_number_to_use = region_number
      #   #     puts "New region number - #{region_number_to_use} - Row #{row_index} - Col #{col_index}"
      #     end
      #   #   puts "Using region number - #{region_number_to_use} - Row #{row_index} - Col #{col_index}"
      #   # else
      #   #   puts "Leaving Row #{row_index} - Col #{col_index} set to #{disk[row_index][col_index]}"
      #   end
      # end
      # total_used = total_used + knot_hash_binary_chars.select { |c| c.to_i == 1 }.count
      # # puts "Total Used is #{total_used} - for row #{row_index} is #{knot_hash_binary_chars.select { |c| c.to_i == 1 }.count}"
    # end
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
    l.gsub("\s+", " ").split(/:/)
  end

  def split_into_words(l)
    l.gsub("\s+"," ").split(" ")
  end

  def split_into_chars(l)
    l.split("")
  end

  def knot_hash(string)
    list = (0..255).to_a
    position = 0
    skip_size = 0
    dense_hash = []
    knot_hash = ""
    ascii_codes = split_into_chars(string)
    # puts "#{ascii_codes}"
    ascii_codes = ascii_codes.map { |c| c.ord }
    # puts "#{ascii_codes}"
    ascii_codes << [17, 31, 73, 47, 23]
    ascii_codes.flatten!
    # puts "#{ascii_codes}"
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
    # puts "#{list} - #{list.length}"
    list.each_slice(16).each do |a|
      # puts "#{a}"
      dense_hash << a.reduce(:^)
    end
    knot_hash = dense_hash.map { |dh| dh.to_s(16) }.map { |dh| dh.length == 1 ? "0" + dh : dh }.join("")
    # puts knot_hash.length
    # puts "Ex B: Knot hash is #{knot_hash}"
    return knot_hash
  end

  def find_region(disk, region_number, row_index, col_index)
    row = row_index
    col = col_index
    disk[row][col] = region_number
    if disk[row-1] and row-1>=0 and disk[row-1][col] == '#'
      find_region(disk, region_number, row-1,col)
    end
    if disk[row+1] and row+1<=disk.length and disk[row+1][col] == '#'
      find_region(disk, region_number, row+1,col)
    end
    if disk[row][col-1] and col-1>=0 and disk[row][col-1] == '#'
      find_region(disk, region_number, row, col-1)
    end
    if disk[row][col+1] and col+1<=disk[row].length and disk[row][col+1] == '#'
      find_region(disk, region_number, row, col+1)
    end
  end



  #   puts "Row Index - #{row_index} - Col Index - #{col_index} - Col Index + 1 #{disk[row_index][col_index+1]}" if disk[row_index][col_index+1]
  #   puts "Row Index - #{row_index} - Col Index - #{col_index} - Row Index + 1 #{disk[row_index+1][col_index]}" if disk[row_index+1]
  #   return disk[row_index-1][col_index].to_s if disk[row_index-1] and disk[row_index-1][col_index].is_a? Numeric
  #   return disk[row_index][col_index-1].to_s if disk[row_index][col_index-1] and disk[row_index][col_index-1].is_a? Numeric
  #   return disk[row_index][col_index+1].to_s if disk[row_index][col_index+1] and disk[row_index][col_index+1].is_a? Numeric
  #   return disk[row_index+1][col_index].to_s if disk[row_index+1] and disk[row_index+1][col_index].is_a? Numeric
  #   return nil
  #   #  ) or (disk[row_index][col_index+1] and disk[row_index][col_index+1].to_i == 1) or ) or (disk[row_index+1] and disk[row_index+1][col_index].to_i == 1))
  # end
end

day = Day.new

puts day.ex_a
# puts Day.ex_b