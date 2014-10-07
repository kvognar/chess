# encoding: utf-8
class Queen < SlidingPiece
  
  def to_s
    @color == "white" ? "♕" : "♛"
  end
  
  def vector
    STRAIGHT + DIAGONAL
  end
  
end