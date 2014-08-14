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