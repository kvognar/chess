class CPU_Player
  attr_reader :color
  
  def initialize(board, game, color)
    @game = game
    @color = color
    @board = board
  end
  
  def make_move
    
    if @board.jump_possible?(@color)
      movable_pieces = @board.pieces(@color).select do |piece|
        piece.jumps.count > 0
      end
      make_jump(movable_pieces)
    else 
      movable_pieces = @board.pieces(@color).select do |piece|
        piece.slides.count > 0
      end
      make_slide(movable_pieces)
    end
    
  end
  
  def make_slide(pieces)
    puts "sliding!"
    piece = pieces.sample
    @game.touch_piece(piece.pos)
    @game.touch_piece(piece.slides.sample)
  end
  
  def make_jump(pieces)
    puts "jumping!"
    piece = pieces.sample
    test_board = @board.dup
    test_piece = test_board[piece.pos]
    moves = []
    while test_piece.jumps.count > 0
      moves << test_piece.jumps.sample
      p moves
      perform_faux_jump(test_board, test_piece, moves.last)
    end

    @game.touch_piece(piece.pos)
    moves.each { |move| @game.plan_move(move) }
    @game.touch_piece(moves.last)    
  end
  
  def perform_faux_jump(board, piece, move)
    piece.jump!(move)
  end

end