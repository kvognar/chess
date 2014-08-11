require 'yaml'

class Tile
  attr_accessor :neighbors
  attr_reader :hidden_value, :revealed
  def initialize value
    @hidden_value = value
    # set true / false @bomb
    @display_value = '*'
    @revealed = false
    @neighbors = []
    @flagged = false
  end
  
  def to_s
    @display_value
  end
  

  
  # def neighbors
  #   @neighbors ||= neighbor_tile_positions.map do |pos|
  #     @board[pos]
  #   end
  # end
  

  
  def is_bomb?
    @hidden_value == 'B'
  end
  
  def neighbor_bomb_count
    @neighbors.select {|nei| nei.is_bomb? }.count
  end
  
  def flag!
    return if @revealed
    @flagged = !@flagged
    @display_value = @flagged ? 'F' : '*'
  end
  
  def reveal!
   return if @revealed || @flagged
   @revealed = true
   
   if is_bomb?
     @display_value = "B"
     return
   end
   unless neighbor_bomb_count == 0
     @display_value = neighbor_bomb_count.to_s
   else
     @display_value = '_'
     @neighbors.each { |neighbor| neighbor.reveal! }
   end
    
  end
  
end

class Board
  attr_reader :board

  def initialize
    @board = Array.new(9)  { Array.new(9) }
    contents = ['B'] * 10 + ['_'] * 71
    contents.shuffle!
    9.times do |x|
      9.times do |y|
         @board[x][y] = Tile.new(contents.shift)
      end
    end
    populate_neighbors
  end
  
  VECTORS = [
      [1,1],
      [1,-1],
      [-1,1],
      [-1,-1],
      [0,1],
      [0,1],
      [1,0],
      [1,0]
    ]

  def populate_neighbors
    @board.each_with_index do |row, idx|
      row.each_with_index do |tile, idy|
        tile.neighbors = neighbor_tile_positions([idx, idy]).map do |x, y|
          @board[x][y]
        end

      end
    end
  end
  
  def neighbor_tile_positions(pos)
    # get all tile positions
    x, y = pos
    VECTORS.map do |vx, vy|
      [x + vx, y + vy] 
    end.select {|x, y| (0..8).cover?(x) && (0..8).cover?(y) }
  end


  def display
    # y = 0
  #   x_coords = " 2 3 4 5 6 7 8 9"
    @board.each do |row|
      puts row.join(' ')
    end
  end
  
  def reveal_all_bombs
    @board.flatten.each { |tile| tile.reveal! if tile.is_bomb? }
    display
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end
    
    
    


end


class MineSweeper
  
  def initialize
    @game_board = Board.new
  end
  
  def game_loop
    until game_over?
      @game_board.display
      f, x, y = prompt_player
      if f == 'f'
        @game_board.board[8 - y][x].flag!
      elsif f == 'g'
        @game_board.board[8 - y][x].reveal!
      elsif f == 'exit'
        save_the_game
      end
    end
    
    @game_board.reveal_all_bombs
    
    if won? 
      puts "Nice job"
    else
      puts "You lose"
    end
      
  end
  
  def prompt_player 
    puts "Please enter 'f' or 'g' (if you'd like to flag or guess)"
    puts "followed by an x coordinate, then a y coordinate, separated by a comma, no spaces."
    puts "Example: f,1,2"
    puts "Type 'exit' to exit"
    begin
      input = gets.chomp.split(',')
      return ['exit', 0,0] if input[0].include?('exit')
      input = [input[0]] + input[1..-1].map(&:to_i)
      raise ArgumentError.new "Invalid guess option" unless /[fg]/ =~ input[0]
      raise ArgumentError.new "Invalid coordinates" unless input[1..-1].all? { |i| (0..8).cover?(i) } 
      rescue ArgumentError => error
        puts error
      retry
    end
    input
    
  end
  
  def game_over?
    lost? || won?
  end
  
  def lost?
    @game_board.board.flatten.any? {|x| x.revealed && x.is_bomb? }
  end    
  
  def won?
    @game_board.board.flatten.select {|x| !x.is_bomb? }.all? {|x| x.revealed }
  end
  
  def save_the_game
    
    Dir.mkdir('save_games') unless  Dir.directory?('save_games')
    
    puts "Enter a name for this save:"
    save_name = gets.chomp
    File.open("save_games/#{save_name}.sweep", 'w') do |file|
      file << self.to_yaml
    end
    puts "Thanks for playing!"
    exit
  end
  
  def self.load_the_game
    puts "What file will you load?"
    save_games = Dir.glob("save_games/*.sweep").map do |filename|
      filename.gsub(".sweep", '').gsub("save_games/", '')
    puts save_games
    
    begin
      name = gets.chomp
      
      raise ArgumentError.new("No such file") unless save_games.include?(name)
      
    rescue ArgumentError => error
      puts error
      retry
    end
      
      game = YAML::load(File.open("save_games/#{name}.sweep", 'r'))
      game.game_loop
  end
  
  def self.menu
    puts "Welcome to Minesweeper!"
    puts "New game (N) or load a saved game (L)?"
    if gets.chomp.downcase == "n"
      Minesweeper.new.game_loop
    else
      self.load_the_game
    end
  end
  
end



MineSweeper.new.game_loop



#Array.new = [B, B, B, *, *, *].shuffle
#Array.each 