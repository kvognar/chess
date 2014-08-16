require "rspec"
require "deck"

RSpec.describe Deck do
  subject(:deck) { Deck.new }
  let(:cards) {
    
  }
  
  it "should have 52 cards" do
    expect(deck.count).to eq(52)
  end
  
  describe "#draw" do
    
    it "should let you draw one card" do
      # expect(deck.draw!(1)).to be_an(Array) # true

      drawn = deck.draw!(1)
      
      expect(drawn.first).to be_a(Card)
      expect(drawn.length).to eq(1)
      expect(deck.draw!(1)).to contain_exactly(an_instance_of(Card))
      # expect(deck.count).to eq(51)
    end
    
    it "should let you draw multiple cards" do
      #check that 5 things out
      drawn = deck.draw!(5)
      
      #check that all five things are cards
      drawn.each do |element|
        expect(element).to be_a(Card)
      end
      
      # check for ... a duplicate. TODO: check all. 
      expect(drawn.first).not_to be(drawn.last)
      
      # check for 47 cards still in deck. 
      expect(deck.count).to eq(47)
      
    end
    
  end
  
end