# encoding: utf-8
class Pawn < Piece
  
  def initialize(position, color, board)
    @has_not_moved = true
    @y_vector = color == "white"? -1 : 1
    super
  end
  
  def moves
    possible_moves = []
    straight = [[@pos[0] + @y_vector, @pos[1]]]
    straight << [@pos[0] + @y_vector * 2, @pos[1]] if has_not_moved?
    
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
  
  def has_not_moved?
    starting_pos = @color == "white" ? 6 : 1
    @pos[0] == starting_pos
  end
  
  def to_s
    @color == "white" ? "♙" : "♟"
  end
end