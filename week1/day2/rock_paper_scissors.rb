def rps(throw)
  options = ['paper', 'rock', 'scissors']
  cpu_throw = options[rand(0..2)]
  player_index = options.index(throw)
  cpu_index = options.index(cpu_throw)
  
  if cpu_index == (player_index + 1) % 3
    return "#{cpu_throw}, Win"
  elsif cpu_index == player_index - 1
    return "#{cpu_throw}, Lose"
  else
    return "#{cpu_throw}, Tie"
  end
end


print "\n\n"
puts rps("rock")
print "\n\n"
print "\n\n"
puts rps("paper")
print "\n\n"
print "\n\n"
puts rps("scissors")
print "\n\n"
  
  
  
  