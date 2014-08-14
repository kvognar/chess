require_relative 'board'
require_relative 'checkers_gui'

class Checkers
  attr_reader :piece_held
  
  def initialize
    @board = Board.new
    @gui = CheckersGUI.new(self, @board)
    @planned_moves = []
    
    @gui.main
  end
  
  def touch_piece(pos)
    if @piece_held.nil?
      lift_piece(pos)
    else
      place_piece(pos)
    end
    @gui.draw_board
    puts "Game over!" if game_over?
  end
  
  def lift_piece(pos)
    piece = @board[pos]
    return nil if piece.nil? || piece.color != @board.current_turn
    @piece_held = piece
  end
  
  def place_piece(pos)
    @planned_moves << pos unless @planned_moves.last == pos
    begin
      success = @piece_held.perform_moves(@planned_moves)
    rescue InvalidMoveError => e
      puts e.message
    end
    @piece_held = nil
    @planned_moves = []
    @board.switch_turns if success
    # puts @board.current_turn
    puts @board.jump_possible?(@board.current_turn)
  end
  
  def plan_move(pos)
    return unless @piece_held
    test_plan = @planned_moves.dup << pos
    begin
      if @piece_held.valid_move_sequence?(test_plan)
        @planned_moves = test_plan
      else
        @planned_moves = []
      end
    rescue InvalidMoveError => e
      puts e.message
    end
    @gui.draw_board(@planned_moves.dup)
  end
  
  def game_over?
    [:red, :black].any? { |color| @board.pieces(color).empty? }
  end

  
end

Checkers.new