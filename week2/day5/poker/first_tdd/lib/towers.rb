class Towers
  
  def initialize
    @tower = [[3, 2, 1], [], []]
  end
  
  def render
    @tower
  end
  
  def move(src, dst)
    return false unless src.between?(0, 2) && dst.between?(0, 2)
    return false unless @tower[src].length > 0
    return false unless @tower[dst] == [] || @tower[dst].last > @tower[src].last
    @tower[dst].push @tower[src].pop
    true
  end
  
  def won?
    @tower[2].length == 3
  end
  
end


class Game
  def initialize
    @towers = Towers.new
  end
  
  def run
    until @towers.won?
      display
      input = prompt
      unless @towers.move(*input)
        puts "invalid move"
      end
    end
    puts "yayyy"
  end
  
  def prompt
    puts "Move from which peg to which? Give like '0 2'"
    gets.chomp.split(" ").map(&:to_i)
  end
  
  def display
    @towers.render.each_with_index { |peg, index| puts "Peg #{index}: #{peg}" }
  end
end
#
# game = Game.new
# game.run

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end