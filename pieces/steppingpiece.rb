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