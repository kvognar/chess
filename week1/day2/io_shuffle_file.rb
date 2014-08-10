def get_file
  puts "Which file would you like to access?"
  file_name = gets.chomp
end

def read(file_name)
  contents = File.readlines(file_name)
end

def save(file, contents)
  File.open( "{file}-shuffled.txt", "w" ) do |f|
    contents.each do |line|
      f.puts line.chomp
    end
  end 
end




def shuffle_file
  file_name = get_file
  contents = read(file_name)
  contents.shuffle!
  save(file_name, contents)
end

if __FILE__ == $PROGRAM_NAME
  shuffle_file
end