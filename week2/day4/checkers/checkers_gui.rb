require 'tk'

class CheckersGUI
  attr_writer :board
  
  def initialize(game, board)
    @game, @board = game, board
    @root = TkRoot.new { title "Checkers" }
    @rect_size = 40
    
    make_menu(@game)
    make_canvas(@rect_size, @game)
    make_labels(@board)
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
  
  def draw_board(highlights = [])
    @canvas.delete("all") #Saves memory
    draw_grid(@rect_size, highlights)
    draw_pieces(@rect_size)
  end
  
  def update_turn_label(color)
    @turn_label.configure('text', "#{color.to_s.capitalize}'s turn")
  end
  
  def update_error_label(message)
    @error_label.configure('text', message)
  end
  
  def display_game_over(color)
    winner = color == :red ? :black : :red
    message = "Game over! The surviving #{winner.to_s} pieces are free"\
    " to frolic about the checkerboard kingdom."
    Tk.messageBox(
      'title' => "The end has come",
      'message' => message,
      'type' => 'ok'
      )
  end
  
  private
  
  def make_menu(game)
    menu_bar = TkFrame.new(@root) do
      relief 'raised'
      borderwidth 2
    end
    menu_bar.pack('fill' => 'x')
    
    TkButton.new(menu_bar) do
      text 'New'
      command proc { game.new_game }
      grid column: 0, row: 0
    end    
    
    TkButton.new(menu_bar) do
      text 'Save'
      command proc { game.save_game}
      grid column: 1, row: 0
    end
    
    TkButton.new(menu_bar) do
      text 'Load'
      command proc { game.load_game }
      grid column: 2, row: 0
    end
    
    TkButton.new(menu_bar) do
      text 'Quit'
      command proc { exit }
      grid column: 3, row: 0
    end
  end
  
  def make_labels(board)
    @error_label = TkLabel.new(@root) do
      text ''
      padx 15
      pady 5
      pack
    end
    @turn_label = TkLabel.new(@root) do
      text "#{board.current_turn.to_s.capitalize}'s turn"
      padx 15
      pady 5
      pack
    end
  end
  
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