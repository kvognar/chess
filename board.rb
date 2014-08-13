# encoding: utf-8
require 'debugger'
require './pieces.rb'

class Board
  attr_accessor :board
  
  def initialize(blank = false)
    @board = Array.new(8) { Array.new(8) }
    board_setup unless blank
      # @board[0][0] = Rook.new([0, 0], "white", self)
      # @board[0][2] = Bishop.new([0, 2], "black", self)
      # @board[6][0] = Queen.new([6, 0], "white", self)
      # @board[7][7] = Knight.new([7, 7], "black", self)
      # @board[0][1] = King.new([0, 1], "white", self)
      #
      # @board[1][3] = Pawn.new([1, 3], "white", self)
      # @board[5][1] = Pawn.new([5, 1], "black", self)
      # @board[0][5] = Pawn.new([0, 5], "white", self)
      # @board[7][0] = Pawn.new([7, 0], "black", self)
      # @board[1][0] = Pawn.new([1, 0], "white", self)
      #
      # @board[6][7] = King.new([6, 7], "black", self)
      # @board[6][6] = Rook.new([6, 6], "black", self)
      # @board[0][0] = King.new([0,0], "white", self)
      # @board[1][0] = Queen.new([1,0], "black", self)
      # @board[0][1] = Queen.new([0,1], "black", self)
      # @board[1][1] = Queen.new([0,1], "black", self)
      # @board[7][7] = King.new([7,7], "black", self)
  end
  
  def board_setup
    place_royalty("white")
    place_royalty("black")
    place_pawns("black")
    place_pawns("white")
  end
  
  def place_royalty(color)
    royalty = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    
    y = color == "white" ? 7 : 0
    royalty.each_with_index do |piece_type, index|
      @board[y][index] = piece_type.new([y, index], color, self)
    end
  end
  
  def place_pawns(color)
    y = color == "white" ? 6 : 1
    8.times do |index|
      @board[y][index] = Pawn.new([y, index], color, self)
    end
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
    opp_color = color == "white" ? "black" : "white"
    king_pos = find_king(color).pos
    find_pieces(opp_color).any? { |piece| piece.moves.include?(king_pos) }
  end
  
  def is_valid_move?(start, end_pos, print_errors = true)
    piece = @board[start[0]][start[1]]
    
    begin
      raise NilPieceError if piece.nil?
      raise InvalidMoveError unless piece.moves.include?(end_pos)
      raise MoveIntoCheckError if move_into_check?(start, end_pos, piece.color)
    rescue NilPieceError
      puts "There's no piece there" if print_errors
      return false
    rescue InvalidMoveError
      puts "Not a valid move" if print_errors
      return false
    rescue MoveIntoCheckError
      puts "Don't put your king in danger!" if print_errors
      return false
    end
    
    true
  end
  
  def move(start, end_pos)
    piece = @board[start[0]][start[1]]
    return unless is_valid_move?(start, end_pos)
    @board[end_pos[0]][end_pos[1]] = piece
    @board[start[0]][start[1]] = nil
  
    piece.pos = end_pos
  end
  
  def find_pieces(color)
    @board.flatten.select do |tile|
      !tile.nil? && tile.color == color
    end
  end
  
  def find_king(color)
    @board.flatten.find { |tile| tile.class == King && tile.color == color }
  end
  
  def dup
    #get pieces
    all_pieces = @board.flatten.select { |tile| !tile.nil? }
    
    #collect piece data
    board_pieces = all_pieces.map do |piece|
      [piece.class, piece.pos.dup, piece.color.dup]
    end
    
    #new board adds pieces with pieces positions
    dupped_board = Board.new(true)
    board_pieces.each do |piece_type,pos,color|
      dupped_board.board[pos[0]][pos[1]] = piece_type.new(pos, color, dupped_board)
    end
    
    dupped_board
  end
  
  def move_into_check?(start, end_pos, color)
    dupped_board = self.dup
    dupped_board.force_move(start, end_pos)
    dupped_board.in_check?(color)
  end
  
  def checkmate?(color)
    return false unless in_check?(color)
    find_pieces(color).none? do |piece|
      piece.moves.any? do |piece_move|
        is_valid_move?(piece.pos, piece_move, false)
      end
    end
  end
  
  protected
  
  def force_move(start, end_pos)
    piece = @board[start[0]][start[1]]
    @board[end_pos[0]][end_pos[1]] = piece
    @board[start[0]][start[1]] = nil
    piece.pos = end_pos
  end
  

    
  
end

class NilPieceError < ArgumentError
end

class InvalidMoveError < ArgumentError
end

class MoveIntoCheckError < ArgumentError
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
  # show_moves(board)
  # puts board.move_into_check?([0,1], [1,1], "white")
  # puts board.move_into_check?([6,7], [5,7], "black")
  # p board.board[0][0].stats
  p board.in_check?("white")
  p board.checkmate?("white")
  p board.checkmate?("black")
end