# encoding: utf-8

require 'tk'
require 'yaml'
require_relative 'board'
require_relative 'chess_gui'

class Chess
  attr_reader :board

  def initialize
    @board = Board.new
    @board.current_turn = "white"
    @gui = ChessGUI.new(self)
    @gui.draw_static_board
  end
  
  def run(pos)
    touch_piece(pos)    
    @gui.display_check_status
    @gui.display_checkmate if @board.checkmate?(@board.current_turn)
  end
  
    
  def touch_piece(pos)
    piece_pos = pos.map { |i| i / @gui.rect_size }.reverse
    if @piece_held.nil? 
      @piece_held = get_piece(piece_pos)
      @gui.draw_static_board(@piece_held) unless @piece_held.nil?
    else
      @gui.display_players if set_piece(piece_pos)
      @piece_held = nil
      @gui.draw_static_board
    end 
  end  
    
  def get_piece(pos)
    return nil if @board[pos].nil? || @board[pos].color != @board.current_turn
    @board[pos]
  end
  
  def set_piece(pos)
    begin 
    success = @board.move(@piece_held.pos, pos)
    rescue InvalidMoveError  => e
      @gui.error_label.configure('text', e.message)
    end
    
    @gui.error_label.configure('text', '') if success
    success
  end
  
  def save
    filename = Tk.getSaveFile
    File.open(filename, 'w') do |save_file|
      save_file << @board.to_yaml
    end
  end
  
  
  def load
    filename = Tk.getOpenFile
    load_game = YAML::load(File.read(filename))
    @board = load_game
    @gui.draw_static_board
    @gui.display_players
  end
  
  def main
    Tk.mainloop
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.main
end