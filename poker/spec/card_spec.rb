require "rspec"
require "card"

RSpec.describe Card do
  subject(:card) { Card.new(14, :spades) }
  let(:card2) { Card.new(3, :hearts)}
  
  
  it "should know its value" do
    expect(card.value).to eq(14)
    expect(card.suit).to eq(:spades)
  end
  
  it "should have a display value" do
    expect(card.render).not_to be_empty
  end
  
  it "should compare to other cards" do
    expect(card > card2).to be_true
    expect(card < card2).to be_false
  end
  
end