# encoding: utf-8
class King < SteppingPiece
  def to_s
    @color == "white" ? "♔" : "♚"
  end
  
  def vector
    STRAIGHT + DIAGONAL
  end
  
  # def moves
  #   moves = super
  #   moves.select { |move| @board.move_into_check?(@pos, move, @color)}
  # end
  
end