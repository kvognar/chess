# encoding: utf-8
require 'debugger'

require 'tk'
require 'yaml'
require './board.rb'

class ChessGUI

  def initialize
    @board = Board.new
    @root = TkRoot.new { title "Chess" }
    @board.current_turn = "white"
    @rect_size = 40
    
    current_turn = @board.current_turn.capitalize    
    rect_size = @rect_size
    
    make_menu
    @canvas = make_canvas(@rect_size)
    @frame = TkFrame.new { pack }
    make_labels(@board.current_turn)
    draw_static_board
  end
  
  def run(pos)
    touch_piece(pos)    
    display_check_status
    display_checkmate if @board.checkmate?(@board.current_turn)
  end
  

  
  def make_menu
    menu_bar = TkFrame.new(@root) do
      relief 'raised'
      borderwidth 2
    end
    menu_bar.pack('fill'  => 'x')
    
    game = self
    TkButton.new(menu_bar) do
      text "Save"
      command proc { game.save }
      grid column: 0, row: 0
    end
    
    TkButton.new(menu_bar) do
      text "Load"
      command proc { game.load }
      grid column: 1, row: 0
    end
    
    TkButton.new(menu_bar) do
      text "Quit"
      command proc { exit } 
      grid column: 2, row: 0
    end
  end

  
  def make_labels(current_turn)
    @error_label = TkLabel.new(@root) do
      text ''
      padx 15
      pady 15
      pack
    end
    @turn_label = TkLabel.new(@root) do
      text "#{current_turn.capitalize}'s turn"
      padx 15
      pady 15
      pack
    end
    @check_label = TkLabel.new(@root) do
      text ''
      padx 15
      pady 15
      pack
    end
  end
  
  def make_canvas(rect_size)
    canvas = TkCanvas.new(@root) do
      highlightthickness 0
      width (8 ) * rect_size+1
      height (8 ) * rect_size+1
      pack
    end
    canvas.bind("1", proc { |e| run([e.x, e.y]) })
    canvas
  end

  def draw_static_board(piece = nil)
    highlight_squares = []
    highlight_squares = piece.moves << piece.pos unless piece.nil?
    @canvas.delete("all")
    rect_size = @rect_size
    board = @board
    8.times do |x|
      8.times do |y|
        fill = (x+y).even? ? "white" : "green"
        fill = "yellow" if highlight_squares.include?([y, x])
        TkcRectangle.new(@canvas, 
                         x * rect_size,
                         y * rect_size,
                         (x + 1) * rect_size,
                         (y + 1) * rect_size,
                         fill: fill
                         )
     end
   end
   draw_pieces
 end

 
 def draw_pieces
   rect_size = @rect_size
   board = @board
   8.times do |x|
     8.times do |y|
       TkcText.new(@canvas,
                   y * (rect_size) + rect_size / 2,
                   x * (rect_size) + rect_size / 2 - 2,
                   text: board[[x, y]],
                   font: { size: rect_size }
                   )
     end
   end
  end
    
  def touch_piece(pos)
    piece_pos = pos.map { |i| i / @rect_size }.reverse
    if @piece_held.nil? 
      p @piece_held = get_piece(piece_pos)
      draw_static_board(@piece_held) unless @piece_held.nil?
    else
      display_players if set_piece(piece_pos)
      @piece_held = nil
      draw_static_board
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
      @error_label.configure('text', e.message)
    end
    
    @error_label.configure('text', '') if success
    success
  end
  
  def display_players    
    @turn_label.configure('text', "#{@board.current_turn.capitalize}'s turn")
  end
  
  def display_check_status
    if @board.in_check?(@board.current_turn)
      @check_label.configure('text', "#{@board.current_turn.capitalize} is in check")
    else
      @check_label.configure('text', '')
    end
  end
  
  def display_checkmate
    winner = @board.current_turn == "white" ? "black" : "white"
    Tk.messageBox( 
      'title'  => "Mate", 
      'message' =>  "Checkmate! #{winner.capitalize} wins.", 
      'type'  =>  'ok'
      )
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
    draw_static_board
    display_players
  end
  
  def main
    Tk.mainloop
  end

end

if __FILE__ == $PROGRAM_NAME
  board = ChessGUI.new
  board.main
end