require 'tk'

class CheckersGUI
  
  def initialize(game, board)
    @game, @board = game, board
    @root = TkRoot.new { title "Checkers" }
    @rect_size = 40
    
    make_canvas(@rect_size, @game)
    draw_board
  end
  
  def touch(touch_pos)
    @game.touch_piece(board_pos(touch_pos))
  end
  
  def plan(touch_pos)
    @game.plan_move(board_pos(touch_pos))
  end  
  
  def main
    Tk.mainloop
  end
  
  private
  
  def make_canvas(rect_size, game)
    @canvas = TkCanvas.new(@root) do
      highlightthickness 0
      width (8 * rect_size + 1)
      height(8 * rect_size + 1)
      pack
    end
    
    @canvas.bind("1", proc { |e| touch([e.x, e.y]) })
    @canvas.bind("2", proc { |e| plan([e.x, e.y]) })
  end
  
  def draw_board(highlights = [])
    @canvas.delete("all") #Saves memory
    draw_grid(@rect_size, highlights)
    draw_pieces(@rect_size)
  end
  
  def draw_grid(rect_size, highlights)
    8.times do |x|
      8.times do |y|
        fill = (x+y).even? ? "red" : "black"
        fill = "cyan" if highlights.include?([y,x])
        TkcRectangle.new(@canvas,
                         x * rect_size,
                         y * rect_size,
                         (x + 1) * rect_size,
                         (y + 1) * rect_size,
                         fill: fill)
      end
    end
  end
  
  def draw_pieces(rect_size)
    @board.pieces.each do |piece|
      fill = piece == @game.piece_held ? "green" : "black"
      TkcText.new(@canvas,
                  piece.pos[1] * rect_size + rect_size / 2,
                  piece.pos[0] * rect_size + rect_size / 2,
                  text: piece,
                  font: { size: rect_size },
                  fill: fill
                  )
    end
  end
  
  def board_pos(touch_pos)
    touch_pos.map { |i| i / @rect_size }.reverse
  end
  
end