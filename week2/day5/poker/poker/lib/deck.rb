require_relative "card"

class Deck
  
  def initialize(shuffle = true)
    populate(shuffle)
  end
  
  def count
    @stack.count
  end
  
  def draw!(num)
    deal = []
    num.times { deal.push @stack.shift }
    # because drawing from the tail / bottom is just *wrong*
    deal
  end
    
  
  private
  def populate(shuffle)
    @stack = []
    Card::DISPLAY_VALUES.keys.each do |value|
      Card::DISPLAY_SUITS.keys.each do |suit|
        @stack << Card.new(value, suit)
      end
    end
    @stack.shuffle! if shuffle
  end
  
end