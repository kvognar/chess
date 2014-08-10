def substrings(string)
  returned_substrings = []
  (string.length).times do |i|
    (i).upto(string.length-1) do |j|
      returned_substrings << string[i..j]
    end
  end
  returned_substrings
end

def subwords(string)
  all_substrings = substrings(string)
  dictionary = []
  File.foreach("dictionary.txt") do |line|
    dictionary << line.chomp
  end
  all_substrings.select { |word| dictionary.include?(word) }
end    

puts
print substrings("hello")
print subwords("antidisestablishmentarianism")
puts
      