# encoding: utf-8

class Piece
  attr_accessor :pos
  attr_reader :color
  
  STRAIGHT = [
    [-1, 0],
    [1, 0],
    [0, 1],
    [0, -1]
  ]
  
  DIAGONAL = [
    [-1, 1],
    [-1, -1],
    [1, 1],
    [1, -1]
  ]
  
  def initialize(position, color, board)
    @pos, @color, @board = position, color, board
  end
  
  
  def stats
    { 
      "name:" => self.class,
      "pos:"  => @pos,
      "color:" => @color,  
      "moves:" => moves
    }
  end
  
end

class SlidingPiece < Piece #init(pos, board, color)

  
  def moves
    moves = []  
    vector.each do |x,y|
      (1..8).each do |slide_length|
        cur_move = [@pos[0] + slide_length * x, @pos[1] + slide_length * y]
        next unless cur_move.all? { |coord| coord.between?(0,7) }
        
        piece_at_pos = @board[cur_move]
        
        case
        when piece_at_pos.nil?
          moves << cur_move
        when piece_at_pos.color != @color
          moves << cur_move
          break
        when piece_at_pos.color == @color
          break
        end

      end
    end
    moves
  end
  
  
end

class Rook < SlidingPiece  
  def to_s
    @color == "white" ? "♖" : "♜"
  end
    
  def vector
    STRAIGHT
  end
end

class Bishop < SlidingPiece
  
  def to_s
    @color == "white" ? "♗" : "♝"
  end
  
  def vector
    DIAGONAL
  end
  
end

class Queen < SlidingPiece
  
  def to_s
    @color == "white" ? "♕" : "♛"
  end
  
  def vector
    STRAIGHT + DIAGONAL
  end
  
end

class SteppingPiece < Piece
  
  def moves
    moves = []  
    vector.each do |x,y|
      cur_move = [@pos[0] + x, @pos[1] + y]
      next unless cur_move.all? { |coord| coord.between?(0,7) }
    
      piece_at_pos = @board[cur_move]
      moves << cur_move if piece_at_pos.nil? || piece_at_pos.color != @color
    end
    moves
  end
  
end

class King < SteppingPiece
  
  def to_s
    @color == "white" ? "♔" : "♚"
  end
  
  def vector
    STRAIGHT + DIAGONAL
  end
  

  
end

class Knight < SteppingPiece
  
  VECTOR = [
    [1, 2],
    [-1, 2],
    [1, -2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]
  
  def to_s
    @color == "white" ? "♘" : "♞"
  end
  
  def vector
    VECTOR
  end
  
  
end

class Pawn < Piece
  
  def initialize(position, color, board)
    @has_not_moved = true
    @y_vector = color == "white"? -1 : 1
    super
  end
  
  def moves
    possible_moves = []
    straight = [[@pos[0] + @y_vector, @pos[1]]]
    straight << [@pos[0] + @y_vector * 2, @pos[1]] if @has_not_moved
    
    straight.each do |move|
      if move.all? { |coord| coord.between?(0,7) } && @board[move].nil? 
        possible_moves << move
      else
        break
      end
    end
    
    #check for enemies 
    possible_captures = [1, -1].map { |dx| [@pos[0] + @y_vector, @pos[1] + dx] }
    
    possible_captures.each do |capture|
      next unless capture.all? { |coord| coord.between?(0,7) }
      unless @board[capture].nil? || @board[capture].color == @color
        possible_moves << capture #if @board[capture].color != @color
      end
    end
    
    possible_moves
  end
  
  def to_s
    @color == "white" ? "♙" : "♟"
  end
end



