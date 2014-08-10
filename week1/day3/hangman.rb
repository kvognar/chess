class Game
  
  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @word_state = nil
    @wrong_guesses = 0
    @previous_guesses = []
    
  end
  
  def game_loop
    game_over = false
    
    get_secret_word

    until game_over?
      guess = get_guess
      position = get_position(guess)
      if position.empty?
        @wrong_guesses += 1
      else
        update_word_state(position, guess)
      end
      show_remaining_guesses
    end
      
    display_result    
  end
  
  
  def show_remaining_guesses
    puts "You have #{ 10 - @wrong_guesses } guesses left."
  end
  
  def get_position(guess)
    begin
      position = @checking_player.check_guess(guess, @word_state)
      is_position_valid?(position)
    rescue PositionError => error
      puts error
      retry
    end
  end
  
  def get_guess
    begin
      guess = @guessing_player.guess(@word_state)
      is_guess_valid?(guess)
      
    rescue GuessError => error
      puts error
      retry
    end
    @previous_guesses << guess
    guess
  end
  
  def get_secret_word
    begin
      @word_state =  "_" * Integer(@checking_player.pick_secret_word)
      
      rescue ArgumentError => error
        puts error
        retry
      
      is_length_valid?(@word_state.length)
      
      rescue WordLengthError => error
        puts error
        retry
    end
  end
  
  def display_result   
    if game_won?
      puts "#{@guessing_player.name} rules!" 
    else
      puts "#{@checking_player.name} is super classy!"
      @checking_player.reveal_answer
    end
  end
  
  def game_over?
    game_won? || game_lost?
  end
  
  def game_lost?
    @wrong_guesses > 9
  end
  
  def game_won?
    !@word_state.include?("_")
  end
  
  def update_word_state(position, guess)
    position.each { |pos| @word_state[pos - 1] = guess }
  end
  
  private
  
  def is_guess_valid?(guess)
    raise GuessError.new("Not a letter") unless /[a-z]/ === guess 
    raise GuessError.new("Guess must be exactly 1 letter") unless guess.length == 1
    raise GuessError.new("Already guessed!") unless !@previous_guesses.include?(guess) 
  end
  
  def is_length_valid?(input)
    raise WordLengthError.new('Word is too long!') unless input > 0 && 
          input <= "antidisestablishmentarianism".length
  end
  
  def is_position_valid?(position)
    position.each do |pos|
      if pos < 1
        raise PositionError.new("Not a valid position")
        break
      elsif pos > @word_state.length
        raise PositionError.new("The word isn't that big!")
        break
      elsif @word_state[pos - 1] != "_"
        raise PositionError.new("There's already a letter there!")
        break
      end
    end    
  end
  
  
end

class HumanPlayer
  attr_reader :name
  
  def initialize(name = "Hugh Mann")
    @name = name
  end
  
  def pick_secret_word
    puts "Enter length of your Secret Word"
    length = gets.chomp
  end
  
  def receive_secret_length(length)
    puts "the word is #{length} letters long"
  end
  
  def guess(word_state)
    display(word_state)
    input = gets.chomp.downcase
  end
  
  def check_guess(guess, word_state)
    puts "Opponent guesses #{guess}."
    display(word_state)
    pos = [0]
  
    puts "Enter positions (if any) where that letter occurs. \n
          Separate them by spaces!"
    pos = gets.chomp.split(" ").map(&:to_i)
  end
  
  def reveal_answer
    
  end
  
  private
  
  def display(word_state)
    puts "Secret word: #{word_state}"
  end
end


class ComputerPlayer
  attr_reader :name
  
  def initialize(name = "Tandy 4000")
    @name = name
    @dictionary = load_dictionary

    @available_guesses = ("a".."z").to_a
  end
  
  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end
  
  def receive_secret_length(length)
    # @opponent_word_length = length
  end
    
  def guess(word_state)
    input = @available_guesses.sample
    @available_guesses.delete(input)
    input
  end
  
  def check_guess(guess, word_state)      
    [].tap do |position| 
      @secret_word.length.times do |index|
        position << (index + 1) if @secret_word[index] == guess
      end
    end
  end
  
  
  def reveal_answer
    puts "My secret word was #{@secret_word}!"
  end
  
  private
  
  def load_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end
end

class WordLengthError < ArgumentError
end

class GuessError < ArgumentError
end

class PositionError < ArgumentError
end

if __FILE__ == $PROGRAM_NAME
  human = HumanPlayer.new("Herbert")
  cpu = ComputerPlayer.new("BMO")
  game = Game.new(human, cpu)
  
  game.game_loop
end