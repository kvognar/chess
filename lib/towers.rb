class Towers
  
  def initialize
    @tower = [[3, 2, 1], [], []]
  end
  
  def render
    @tower
  end
  
  def move(src, dst)
    return false unless @tower[src].length > 0
    return false unless @tower[dst] == [] || @tower[dst].last > @tower[src].last
    @tower[dst].push @tower[src].pop
    true
  end
  
  def won?
    @tower[2].length == 3
  end
  
end