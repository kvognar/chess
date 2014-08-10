def guessing_game
  winning_number = rand(1..100)
  numTurns = 0
  
  puts "Let's play a game! Pick a number between 1 and 100!"
  guess = gets.chomp.to_i
  
  until guess == winning_number
    if winning_number > guess
      puts "Too low!"
    elsif winning_number < guess
      puts "Too high!"
    end
  
    puts "What number would you like to guess?"
    guess = gets.chomp.to_i
    numTurns += 1
    
  end
  
  puts "You got it in #{numTurns} turns!"
end
    