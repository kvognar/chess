def remix(drinks)
  alcohols = []
  mixers = []
  
  drinks.each do |drink|
    alcohols << drink[0]
    mixers << drink[1]
  end
  
  shuffled_mixers = mixers.dup
  # Works, but looks funny, refactor later
  # until shuffled_mixers.all? {|mixer| shuffled_mixers.index(mixer) != mixers.index(mixer)}
  #   shuffled_mixers.shuffle!
  # end
  
  shuffled_mixers.shuffle! until shuffled_mixers.all? do |mixer|
    shuffled_mixers.index(mixer) != mixers.index(mixer)
  end
  
  alcohols.each_with_index.map do |alcohol, index| 
    [alcohol, shuffled_mixers[index]]
  end
  # alcohols.zip shuffled_mixers
  
end


puts
print remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
puts
 