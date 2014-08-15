# encoding: utf-8

class Card
  attr_reader :value, :suit
  
  DISPLAY_VALUES = {
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "10",
    11 => "Jack",
    12 => "Queen",
    13 => "King",
    14 => "Ace"
  }
  
  DISPLAY_SUITS = {
    hearts: "♥︎",
    spades: "♠︎",
    diamonds: "♦︎",
    clubs: "♣︎"
  }
  
  def initialize(value, suit)
    @value, @suit = value, suit
  end
  
  def >(other)
    @value > other.value
  end

  def <(other)
    @value < other.value
  end
  
  def render
    "#{DISPLAY_VALUES[@value]}#{DISPLAY_VALUES[@suit]}"
  end
  
end