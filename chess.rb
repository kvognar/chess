# encoding: utf-8
require 'debugger'

require 'tk'
require './board.rb'

class ChessGUI

  def initialize
    @board = Board.new
    @root = TkRoot.new { title "Chess" }
    @current_turn = "white"
    current_turn = @current_turn.capitalize
    
    rect_size = @rect_size = 40
    @canvas = TkCanvas.new(@root) do
      highlightthickness 0
      width (8 + 1) * rect_size
      height (8 + 1) * rect_size
      pack
    end
    
    @canvas.bind("1", proc { |e| touch_piece([e.x, e.y]) })

    @frame = TkFrame.new { pack }
    draw_static_board
    
    @turn_label = TkLabel.new(@root) do
      text "#{current_turn}'s turn"
      padx 15
      pady 15
      pack
    end
  end

  def draw_static_board
    @canvas.delete("all")
    rect_size = @rect_size
    board = @board
    8.times do |x|
      8.times do |y|
        fill = (x+y).even? ? "white" : "green"
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
 
 def draw_highlight_square(piece, pos)
   y, x = piece.pos
   rect_size = @rect_size
   TkcRectangle.new(@canvas, 
                    x * rect_size,
                    y * rect_size,
                    (x + 1) * rect_size,
                    (y + 1) * rect_size,
                    fill: "yellow"
                    )
   TkcText.new(@canvas,
               x * (rect_size) + rect_size / 2,
               y * (rect_size) + rect_size / 2 - 2,
               text: piece,
               font: { size: rect_size }
               )            
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
    piece_pos = pos.map { |i| i / 40 }.reverse
    if @piece_held.nil? 
      p @piece_held = get_piece(piece_pos)
      draw_highlight_square(@piece_held, pos) unless @piece_held.nil?
    else
      switch_players if set_piece(piece_pos)
      @piece_held = nil
      draw_static_board
    end 
  end
  
  
  
  def get_piece(pos)
    return nil if @board[pos].nil? || @board[pos].color != @current_turn
    @board[pos]
  end
  
  def set_piece(pos)
    # @piece_held 
    @board.move(@piece_held.pos, pos)
  end
  
  def switch_players
    @current_turn = @current_turn == "white" ? "black" : "white"
    @turn_label.configure('text', "#{@current_turn.capitalize}'s turn")
  end
  
  def main
    Tk.mainloop
  end

  
end

if __FILE__ == $PROGRAM_NAME
  board = ChessGUI.new
  board.main
end