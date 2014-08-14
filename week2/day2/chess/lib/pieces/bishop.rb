# encoding: utf-8
class Bishop < SlidingPiece
  
  def to_s
    @color == "white" ? "♗" : "♝"
  end
  
  def vector
    DIAGONAL
  end
  
end