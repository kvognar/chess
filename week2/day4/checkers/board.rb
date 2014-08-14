require_relative 'piece'

class Board
  attr_reader :grid
  
  def initialize(empty = false)
    @grid = Array.new(8) { Array.new(8) }
    [:black, :red].each { |color| place_pieces(color) } unless empty
  end
  
  def place_pieces(color)
    rows = color == :black ? [0, 1, 2] : [5, 6, 7]
    rows.each do |row|
      8.times do |column|
        next if (row + column).odd?
        self[[row, column]] = Piece.new(color, [row, column], self)
      end
    end
  end
  
  def [](pos)
    y, x = pos
    return nil if @grid[y].nil?
    @grid[y][x]
  end
  
  def []=(pos, element)
    y, x = pos
    @grid[y][x] = element
  end
  
  def display
    @grid.each do |row|
      p row
    end
  end
  
  def move_piece(piece, pos)
    self[piece.pos] = nil
    self[pos] = piece
  end
  
  def jump_piece(piece, pos, victim_pos)
    self[piece.pos] = nil
    self[pos] = piece
    self[victim_pos] = nil
  end
  
  def dup
    piece_data = pieces.map do |piece|
      [piece.color, piece.pos.dup, piece.king]
    end
    dup_board = Board.new(true)
    piece_data.each do |color, pos, king|
      dup_board[pos] = Piece.new(color, pos, king, dup_board)
    end
    dup_board
  end
  
  def pieces
    @grid.flatten.compact
  end
    
  
end



# test jumps
def test_jumps(jumps)
  test_board = Board.new(true)
  test_board[[1,1]] = Piece.new(:black, [1,1], test_board)
  test_board[[2,2]] = Piece.new(:white, [2,2], test_board)
  test_board[[4,2]] = Piece.new(:white, [4,2], test_board)
  test_board[[6,2]] = Piece.new(:white, [6,2], test_board)
  test_board.display
  p test_board[[1,1]].moves
  test_board[[1,1]].perform_moves(jumps)

  test_board.display
end

test_jumps([[3,3], [5,1], [7,3]])
test_jumps([[3,3], [6,1], [7,3]])
test_jumps([[2,0]])