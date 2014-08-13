# encoding: utf-8
class King < SteppingPiece
  def to_s
    @color == "white" ? "♔" : "♚"
  end
  
  def vector
    STRAIGHT + DIAGONAL
  end
end