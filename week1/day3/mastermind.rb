require 'debugger'

class Code
  
  COLORS = %w{R G B Y O P}
  
  def initialize
    @code = random
  end
  
  def parse(input)
    compare(input.split(""))
  end
  
  def compare(input_array)
    exact_match = 0
    near_match = 0
    input_array.each_with_index do |peg, idx|
      unless input_array[0...idx].include?(peg)
        near_match += [input_array.count(peg), @code.count(peg)].min
      end
      if peg == @code[idx]
        exact_match += 1
        near_match -= 1
      end
    end
    [exact_match, near_match]
  end
  
  def random
    COLORS.sample(4)
  end
  
  def self.validate?(input)
    input.length == 4 && input.split("").all? { |peg| COLORS.include?(peg) }
  end
  
end

class Game
  
  def initialize
    @turns_taken = 0
    @game_code = Code.new
    @guess_record = []
  end
  
  def prompt_user
    valid_response = false
    until valid_response
      puts "What is your guess?: "
      input = gets.chomp.upcase
      valid_response = Code.validate?(input)
    end
    input
  end

  def welcome
    puts "This is Mastermind. Try to guess the 4-color sequence I'm thinking. \n
    Choose from the following colors: ROYGBP \n"
  end
  
  def game_loop
    welcome 
    
    until game_over?
      input = prompt_user
      matches = @game_code.parse(input)
      @guess_record << [input, matches]
      @turns_taken += 1
      display_board
    end
    outcome
  end
  
  def game_over?
    return false if @turns_taken == 0
    @turns_taken > 9 || @guess_record.last[1][0] == 4
  end
  
  def outcome
    if @turns_taken < 10
      puts "You won!" 
    else
      puts "You lost!"
    end
  end
  
  def display_board
    @guess_record.each { |guess| puts "~{ #{guess[0]} | #{guess[1]} }~" }
    puts "You have #{ 10 - @turns_taken } guesses left!"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.game_loop
end