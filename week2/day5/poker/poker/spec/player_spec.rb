require 'rspec'
require 'player'

RSpec.describe Player do
  
  subject(:player) { Player.new("Finn") }
  
  describe "#bet" do
    
    it "should return a bet" do
      # gets = double(gets) { "100\n" }
      player.stub!(:gets) { "100\n" }
    end
  end
  
end