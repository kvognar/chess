

require 'rspec'
require 'hand'
require 'card'

RSpec.describe Hand do
  
  subject(:hand) { Hand.new }
  
  
  describe "New hand" do
    it "should be empty" do
      expect(hand.cards.count).to eq(0)
    end
  end
  
  describe "no pair" do
    before(:each) do
      hand.deal(
        Card.new(14, :diamonds),
        Card.new(7,  :hearts),
        Card.new(5,  :clubs),
        Card.new(3,  :diamonds),
        Card.new(2,  :spades)
      )
    end
    
    it "should identify as no pair" do
      expect(hand.rank).to be(:no_pair)
    end
  end
  
  describe "one pair" do

    before(:each) do 
      hand.deal(
        Card.new(2, :hearts),
        Card.new(2, :spades),
        Card.new(4, :spades),
        Card.new(7, :clubs),
        Card.new(14, :diamonds)
        )
    end
    it "should identify as a pair" do
      expect(hand.rank).to be(:one_pair)
    end
    
    it "should give a one-pair score" 
    
  end
  
  describe "two pair" do
    
    before(:each) do
      hand.deal(
        Card.new(2, :spades),
        Card.new(2, :hearts),
        Card.new(7, :clubs),
        Card.new(7, :hearts),
        Card.new(10, :diamonds)
        )
    end
    
    it "should identify as two-pair" do
      expect(hand.rank).to be(:two_pair)
    end
    
    it "should give a two-pair score"#

  end

  describe "three of a kind" do

    before(:each) do
      hand.deal(
      Card.new(3, :spades),
      Card.new(3, :hearts),
      Card.new(3, :diamonds),
      Card.new(8, :clubs),
      Card.new(9, :clubs)
      )
    end

    it "should identify as three of a kind" do
      expect(hand.rank).to be(:three_of_a_kind)
    end
  end

  describe "straight" do
    before(:each) do
      hand.deal(
        Card.new(12, :spades),
        Card.new(11, :diamonds),
        Card.new(10, :clubs),
        Card.new(9,  :spades),
        Card.new(8,  :hearts)
      )
    end

    it "should identify as a straight" do
      expect(hand.rank).to be(:straight)
    end
  end

  describe "flush" do
    before(:each) do
      hand.deal(
        Card.new(13, :spades),
        Card.new(11, :spades),
        Card.new(9,  :spades),
        Card.new(7,  :spades),
        Card.new(3,  :spades)
      )
    end

    it "should identify as a flush" do
      expect(hand.rank).to be(:flush)
    end
  end

  describe "full house" do
    before(:each) do
      hand.deal(
        Card.new(13, :hearts),
        Card.new(13, :diamonds),
        Card.new(13, :spades),
        Card.new(5,  :hearts),
        Card.new(5,  :clubs)
      )
    end

    it "should identify as a full house" do
      expect(hand.rank).to be(:full_house)
    end
  end

  describe "four of a kind" do
    before(:each) do
      hand.deal(
        Card.new(5,  :diamonds),
        Card.new(5,  :spades),
        Card.new(5,  :hearts),
        Card.new(5,  :clubs),
        Card.new(3,  :hearts)
      )
    end

    it "should identify as four of a kind" do
      expect(hand.rank).to be(:four_of_a_kind)
    end
  end

  describe "straight flush" do
    before(:each) do
      hand.deal(
        Card.new(8,  :clubs),
        Card.new(7,  :clubs),
        Card.new(6,  :clubs),
        Card.new(5,  :clubs),
        Card.new(4,  :clubs)
      )
    end

    it "should identify as a straight flush" do
      expect(hand.rank).to be(:straight_flush)
    end
  end

  describe "royal flush" do
    before(:each) do
      hand.deal(
        Card.new(14, :hearts),
        Card.new(13, :hearts),
        Card.new(12, :hearts),
        Card.new(11, :hearts),
        Card.new(10, :hearts)
      )
    end

    it "should identify as a royal flush" do
      expect(hand.rank).to be(:royal_flush)
    end
  end

end