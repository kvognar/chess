class ChessGUI
  attr_reader :rect_size
  attr_accessor :error_label, :check_label, :turn_label
  
  def initialize(game)
    @game = game
    
    @root = TkRoot.new { title "Chess" }
    @rect_size = 40
    make_menu
    @canvas = make_canvas(@rect_size)
    @frame = TkFrame.new { pack }
    make_labels(@game.board.current_turn)
  end
  
  def make_menu
    menu_bar = TkFrame.new(@root) do
      relief 'raised'
      borderwidth 2
    end
    menu_bar.pack('fill'  => 'x')
    
    game = @game
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
      width (8) * rect_size + 1
      height (8) * rect_size + 1
      pack
    end
    game = @game
    canvas.bind("1", proc { |e| game.run([e.x, e.y]) })
    canvas
  end
  
  def draw_static_board(piece = nil)
    highlight_squares = []
    highlight_squares = piece.moves << piece.pos unless piece.nil?
    @canvas.delete("all")
    rect_size = @rect_size
    board = @game.board
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
   board = @game.board
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
  
  def display_players    
    @turn_label.configure('text', "#{@game.board.current_turn.capitalize}'s turn")
  end
  
  def display_check_status
    if @game.board.in_check?(@game.board.current_turn)
      @check_label.configure('text', "#{@game.board.current_turn.capitalize} is in check")
    else
      @check_label.configure('text', '')
    end
  end
  
  def display_checkmate
    winner = @game.board.current_turn == "white" ? "black" : "white"
    Tk.messageBox( 
      'title'  => "Mate", 
      'message' =>  "Checkmate! #{winner.capitalize} wins.", 
      'type'  =>  'ok'
      )
  end
  
end