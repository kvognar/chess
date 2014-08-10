require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_nodes = []
    3.times do |x|
      3.times do |y|
        child_nodes << make_child(x, y) if @board[[x, y]].nil?
      end
    end
    child_nodes                   
  end
  
  def make_child(x, y)
    duped_board = @board.dup
    duped_board[[x, y]] = next_mover_mark
    prev_move_pos = [x, y]
    next_mover_mark = (@next_mover_mark == :x ? :o : :x)
    child_node = TicTacToeNode.new(duped_board, next_mover_mark, prev_move_pos) 
  end

  def losing_node?(player)
    if @board.over?
      board.winner != player && !board.winner.nil?
    elsif @next_mover_mark == player
      children.all? { |child| child.losing_node?(player) }
    else 
      children.any? { |child| child.losing_node?(player) }
    end
  end
    

  def winning_node?(player)
    if @board.over?
      board.winner == player
    elsif @next_mover_mark == player
      children.any? { |child| child.winning_node?(player) }
    else
      children.all? { |child| child.winning_node?(player) }
    end
  end
  
end
