# encoding: utf-8
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