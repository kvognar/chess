require "rspec"
require "towers"

RSpec.describe(Towers) do
  subject(:towers) { Towers.new }
  describe "#render" do
    it "should start with 3 tiles on peg 1" do
      expect(towers.render).to eq([[3, 2, 1], [], []])
    end
  end # /render
  
  describe "#move" do
    
    it "should move pieces to empty pegs" do
      towers.move(0, 1)
      expect(towers.render).to eq([[3, 2], [1], []])
    end
    
    it "should not move big pieces onto smaller ones" do
      towers.move(0, 1)
      towers.move(0, 1)
      expect(towers.render).to eq([[3, 2], [1], []])
    end
    
    it "should not move out of an empty peg" do
      towers.move(1, 2)
      expect(towers.render).to eq([[3, 2, 1], [], []])
    end
    
  end
end # /Tower
