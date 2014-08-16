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
    
    it "should not move nonexistent pegs" do
      expect(towers.move(9, 9)).to be_false
    end
  end
  
  describe "#won?" do    

    it "should be false at start of game" do 
      expect(towers.won?).to be_false
    end
    
    it "should be true once new tower is made" do
      towers.move(0, 2)
      towers.move(0, 1)
      towers.move(2, 1)
      towers.move(0, 2)
      towers.move(1, 0)
      towers.move(1, 2)
      towers.move(0, 2)
      expect(towers.won?).to be_true
    end
    
  end
end # /Tower


RSpec.describe Game do
  
  subject { Game.new }
  
  describe "#prompt" do
    
    it "should read input correctly" do
      subject.stub(:gets)  {"0 2"}
      expect(subject.prompt).to eq([0, 2])
    end
  end
  
end