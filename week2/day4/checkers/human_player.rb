class Player
  
  def initialize
    @move_plan = []
  end
  
  def plan_jump(pos)
    @move_plan << pos
  end
  
  def make_move(pos)
    @move_plan << pos
  end
  
  
  
end