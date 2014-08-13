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