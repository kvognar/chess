require_relative 'hand'

class Player
  
  def initialize(name)
    @name = name
    @hand = Hand.new
    @pot = 10_000
  end
  
  def display_cards
    @hand.cards.each_with_index do |card, index|
      puts "#{index}: #{card}"
    end
  end
  
  def bet
    display_c
  end
  
  
end