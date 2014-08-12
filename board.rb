# encoding: utf-8

require './pieces.rb'

class Board
  attr_accessor :board
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @board[0][0] = Rook.new([0, 0], "white", self)
    @board[0][2] = Bishop.new([0, 2], "black", self)
    @board[6][0] = Queen.new([6, 0], "white", self)
    @board[7][7] = Knight.new([7, 7], "black", self)
    @board[0][1] = King.new([0, 1], "white", self)
    
    @board[1][3] = Pawn.new([1, 3], "white", self)
    @board[5][1] = Pawn.new([5, 1], "black", self)
    @board[0][5] = Pawn.new([0, 5], "white", self)
    @board[7][0] = Pawn.new([7, 0], "black", self)
    @board[1][0] = Pawn.new([1, 0], "white", self)
    
    @board[6][7] = King.new([6, 7], "black", self)
    @board[6][6] = Rook.new([6, 6], "black", self)
  end
  
  def display
    @board.each do |row|
      puts row.join(" ")
    end
  end
  
  def [](pos)
    x, y = pos[0], pos[1]
    @board[x][y]
  end
  
  def in_check?(color)
    king_pos = find_king(color).pos
    find_opp_pieces(color).any? { |piece| piece.moves.include?(king_pos) }
  end
  
  def move(start, end_pos)
    piece = @board[start[0]][start[1]]
    
    begin
      raise NilPieceError if piece.nil?
      raise InvalidMoveError unless piece.moves.include?(end_pos)
    rescue NilPieceError
      puts "There's no piece there"
      return
    rescue InvalidMoveError
      puts "Not a valid move"
      return
    end
    
    @board[end_pos[0]][end_pos[1]] = piece
    @board[start[0]][start[1]] = nil
  
    piece.pos = end_pos
  end
  
  def find_opp_pieces(color)
    @board.flatten.select do |tile|
      !tile.nil? && tile.color != color
    end
  end
  
  def find_king(color)
    @board.flatten.find { |tile| tile.class == King && tile.color == color }
  end
  
  def dup
    #get piece positions
    #create new board
    #new board adds pieces with pieces positions
  end
    
  
end

class NilPieceError < ArgumentError
end

class InvalidMoveError < ArgumentError
end

def show_moves(board)
  board.board.each do |row|
    row.each do |cell|
      next if cell.nil?
      p cell.stats
      puts
    end
  end
end

if __FILE__  == $PROGRAM_NAME
  board = Board.new
  board.display
  show_moves(board)
  # p board.board[0][0].stats
end