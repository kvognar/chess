

require 'rspec'
require 'hand'
require 'card'

RSpec.describe Hand do
  
  subject(:hand)        { Hand.new }
  let(:no_pair)         { Hand.new }
  let(:one_pair)        { Hand.new }
  let(:two_pair)        { Hand.new }
  let(:three_of_a_kind) { Hand.new }
  let(:straight)        { Hand.new }
  let(:flush)           { Hand.new }
  let(:full_house)      { Hand.new }
  let(:four_of_a_kind)  { Hand.new }
  let(:straight_flush)  { Hand.new }
  let(:royal_flush)     { Hand.new }
  
  before(:all) do
    no_pair.deal(
      Card.new(14, :diamonds),
      Card.new(7,  :hearts),
      Card.new(5,  :clubs),
      Card.new(3,  :diamonds),
      Card.new(2,  :spades)
    )
    one_pair.deal(
      Card.new(2, :hearts),
      Card.new(2, :spades),
      Card.new(4, :spades),
      Card.new(7, :clubs),
      Card.new(14, :diamonds)
    )
    two_pair.deal(
      Card.new(2, :spades),
      Card.new(2, :hearts),
      Card.new(7, :clubs),
      Card.new(7, :hearts),
      Card.new(10, :diamonds)
    )
    three_of_a_kind.deal(
      Card.new(3, :spades),
      Card.new(3, :hearts),
      Card.new(3, :diamonds),
      Card.new(8, :clubs),
      Card.new(9, :clubs)
    )
    straight.deal(
      Card.new(12, :spades),
      Card.new(11, :diamonds),
      Card.new(10, :clubs),
      Card.new(9,  :spades),
      Card.new(8,  :hearts)
    )
    flush.deal(
      Card.new(13, :spades),
      Card.new(11, :spades),
      Card.new(9,  :spades),
      Card.new(7,  :spades),
      Card.new(3,  :spades)
    )
    full_house.deal(
      Card.new(13, :hearts),
      Card.new(13, :diamonds),
      Card.new(13, :spades),
      Card.new(5,  :hearts),
      Card.new(5,  :clubs)
    )
    four_of_a_kind.deal(
      Card.new(5,  :diamonds),
      Card.new(5,  :spades),
      Card.new(5,  :hearts),
      Card.new(5,  :clubs),
      Card.new(3,  :hearts)
    )
    straight_flush.deal(
      Card.new(8,  :clubs),
      Card.new(7,  :clubs),
      Card.new(6,  :clubs),
      Card.new(5,  :clubs),
      Card.new(4,  :clubs)
    )
    royal_flush.deal(
      Card.new(14, :hearts),
      Card.new(13, :hearts),
      Card.new(12, :hearts),
      Card.new(11, :hearts),
      Card.new(10, :hearts)
    )
  end
      
  describe "New hand" do
    it "should be empty" do
      expect(hand.cards.count).to eq(0)
    end
  end
  
  describe "no pair" do
    it "should identify as no pair" do
      expect(no_pair.rank).to be(:no_pair)
    end
  end
  
  describe "one pair" do
    it "should identify as a pair" do
      expect(one_pair.rank).to be(:one_pair)
    end
    
    it "should give a one-pair score" 
    
  end
  
  describe "two pair" do
    it "should identify as two-pair" do
      expect(two_pair.rank).to be(:two_pair)
    end
    
    it "should give a two-pair score"#

  end

  describe "three of a kind" do
    it "should identify as three of a kind" do
      expect(three_of_a_kind.rank).to be(:three_of_a_kind)
    end
  end

  describe "straight" do
    it "should identify as a straight" do
      expect(straight.rank).to be(:straight)
    end
  end

  describe "flush" do
    it "should identify as a flush" do
      expect(flush.rank).to be(:flush)
    end
  end

  describe "full house" do
    it "should identify as a full house" do
      expect(full_house.rank).to be(:full_house)
    end
  end

  describe "four of a kind" do
    it "should identify as four of a kind" do
      expect(four_of_a_kind.rank).to be(:four_of_a_kind)
    end
  end

  describe "straight flush" do
    it "should identify as a straight flush" do
      expect(straight_flush.rank).to be(:straight_flush)
    end
  end

  describe "royal flush" do
    it "should identify as a royal flush" do
      expect(royal_flush.rank).to be(:royal_flush)
    end
  end
  

  describe "#compare_hands"
  

end