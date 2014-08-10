class Board
  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @winner_mark = nil
  end
    
  def won?
    # Three consecutive
    # Won   
    lines = []
    @board.each { |row| lines << row }
    @board.transpose.each { |col| lines << col }
    diagonals = [ [@board[0][0], @board[1][1], @board[2][2]],
                  [@board[0][2], @board[1][1], @board[2][0]] ]
    diagonals.each { |diag| lines << diag }
    
    lines.any? do |line|
      all_same = line.all? { |mark| mark == line.first }
      not_empty = line.first != " "
      @last_mark = line.first

      all_same && not_empty

    
    end
  end
  
  def winner
    @last_mark
    # Computer or Player
  end
  
  def empty?(x, y)
    # valid mark?
    @board[x][y] == " " 
  end
  
  def place_mark(x, y, mark)
    @board[x][y] = mark
  end

  

end






class Game
  
  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end
  
  def play
    until @board.won?
      # Prompt User Input
      take_turn(@player1)
      puts @board.won?
      break if @board.won?
      take_turn(@player2)

    end
    @player1.display(@board.board)
    puts "#{@board.winner} wins!"
    
  end
  
  def take_turn(player)
    valid_move = false

    until valid_move
      x, y = player.prompt(@board.board)
      valid_move = @board.empty?(x, y)
    end
    # mark move
    @board.place_mark(x, y, player.mark)
  end
  
  
  
end



class HumanPlayer
  attr_reader :mark
  
  def initialize(mark = "X")
    @mark = mark
  end
  
  def display(board)
    board.each { |line| p line }
  end
  
  def prompt(board)
    display(board)
    puts "Which coordinates? Enter like '02'."
    input = gets.chomp
    x, y = input[0].to_i, input[1].to_i 
    # gets move
    #return move
    [x, y]
  end
  
  
  
end

class ComputerPlayer
  
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end
  
  def prompt(board)
    lines = all_lines(board)
    if win_is_possible?(lines)
      return find_winning_move(lines)
    end
    random_move(board)
  end
  
  def all_lines(board)
    lines = []
    board.each { |row| lines << row }
    board.transpose.each { |col| lines << col }
    diagonals = [ [board[0][0], board[1][1], board[2][2]],
                  [board[0][2], board[1][1], board[2][0]] ]
    diagonals.each { |diag| lines << diag }
    lines
  end
    
  def win_is_possible?(lines)
    lines.any? do |line|
      line.count(@mark) == 2 and line.include?(" ")
    end
  end
      
  def random_move(board)
    empty_spaces = []
    3.times do |i|
      3.times do |j|
        empty_spaces << [i, j] if board[i][j] == " "
      end
    end
    
    empty_spaces.sample
  end
        
    
  def find_winning_move(lines)
    
    lines.each_with_index do |line, line_index|
      if line.count(@mark) == 2 and line.include?(" ")
        point_index = line.index(" ")
        p line_index
        p point_index
        if line_index < 3 
          x, y = line_index, point_index
        elsif line_index < 6
          x, y = point_index, line_index - 3
        elsif line_index == 6
          x, y = point_index, point_index
        elsif line_index == 7
          x, y = point_index, 2 - point_index
        end
        return [x, y]
      end       
    end
    #think, respond
  end
  
  
end

player1 = HumanPlayer.new()
player2 = HumanPlayer.new("O")
computerPlayer = ComputerPlayer.new("O")

game = Game.new(player1, computerPlayer)
game.play