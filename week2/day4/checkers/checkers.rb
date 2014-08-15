require 'yaml'
require_relative 'board'
require_relative 'checkers_gui'
require_relative 'cpu_player'

class Checkers
  attr_reader :piece_held
  
  def initialize
    @board = Board.new
    @gui = CheckersGUI.new(self, @board)
    @cpu = CPU_Player.new(@board, self, :black)
    @planned_moves = []
    
    @gui.main
  end
  
  def touch_piece(pos)
    if @piece_held.nil?
      lift_piece(pos)
    else
      place_piece(pos)
    end
    offer_cpu_move
    @gui.draw_board
    @gui.display_game_over(@board.current_turn) if game_over?
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
      @gui.update_error_label(e.message)
    end
    @piece_held = nil
    @planned_moves = []
    if success
      @gui.update_error_label('')
      @board.switch_turns
      @gui.update_turn_label(@board.current_turn)
    end
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
      @gui.update_error_label(e.message)
    end
    @gui.draw_board(@planned_moves.dup)
  end
  
  def game_over?
    [:red, :black].any? { |color| @board.pieces(color).empty? }
  end
  
  def save_game
    filename = Tk.getSaveFile
    File.open(filename, 'w') do |save_file|
      save_file << @board.to_yaml
    end
  end
  
  def load_game
    filename = Tk.getOpenFile
    load_game = YAML::load(File.read(filename))
    @board = load_game
    @planned_moves = []
    @held_piece = nil
    reset_gui
  end
  
  def new_game
    @board = Board.new
    @planned_moves = []
    @held_piece = nil
    reset_gui
  end

  
  private
  
  def offer_cpu_move
    if @board.current_turn == @cpu.color && 
      @piece_held.nil? &&
      game_over? == false
      @cpu.make_move
    end
  end
  
  def reset_gui
    @gui.board = @board
    @gui.draw_board
    @gui.update_turn_label(@board.current_turn)
  end
end

Checkers.new