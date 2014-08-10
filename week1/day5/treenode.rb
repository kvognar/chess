class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    
    @parent = parent
    parent.children << self unless parent.nil?
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil
    else
      raise ArgumentError, "Child not a node" 
    end
  end
  
  def dfs(value)
    return self if value == @value
    
    @children.each do |child| 
      result = child.dfs(value)
      return result if result
    end
    nil
  end
  
  def bfs(value)
    # return self if value == value
    queue = [self]
    
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == value
      queue.concat(current_node.children)
    end
    nil
  end
  
  def trace_path_back
    return [self.value] if parent.nil?
    @parent.trace_path_back.concat([self.value])
  end
    
end