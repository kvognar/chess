require 'debugger'
require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    #debugger
    game_node = TicTacToeNode.new(game.board, mark)
    child_nodes = game_node.children
    child_nodes.each do |child|
      if child.winning_node?(mark)    
        return child.prev_move_pos
      end
    end
    child_nodes.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end
    raise RuntimeError, "An error has occurred" 
  end
  
end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
