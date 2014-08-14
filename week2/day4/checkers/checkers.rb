require_relative 'board'
require_relative 'checkers_gui'

class Checkers
  
  def initialize
    @board = Board.new
    @gui = CheckersGUI.new(self, @board)
    
    @gui.main
  end
  
  def touch_piece(pos)
    if @piece_held.nil?
      @piece_held = get_piece(pos)
      puts @piece_held
      @gui.draw_board
    else
      @piece_held.perform_moves([pos])
      @piece_held = nil
      @gui.draw_board
    end
    
  end
  
  def get_piece(pos)
    @board[pos]
  end
  
end

Checkers.new