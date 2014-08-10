require './treenode'

class KnightPathFinder
  VECTORS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1], 
    [-2, -1]
  ]
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end
  
  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      new_nodes = new_move_positions(current_node.value).map do |move|
        PolyTreeNode.new(move)
      end
      new_nodes.each { |node| node.parent = current_node }
      queue.concat(new_nodes)
    end
    
    root
  end
  
  def self.valid_moves(pos)
    all_moves = []
    x = pos[0]
    y = pos[1]
    
    VECTORS.each do |vec|
      all_moves << [x + vec[0], y + vec[1]]
    end
    all_moves.select do |move|
       move.all? { |i| i.between?(0,7) }
     end
  end
  
  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos) - @visited_positions
    @visited_positions.concat(new_moves)
    new_moves
  end
  
  def find_path(end_pos)
    end_node = build_move_tree.bfs(end_pos)
    end_node.trace_path_back
  end
  
end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0, 0])
  
  p knight.find_path([7, 6])
  
  knight = KnightPathFinder.new([0,0])
  p knight.find_path([6, 2])
end




