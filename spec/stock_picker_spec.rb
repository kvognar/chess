require 'rspec'
require 'arrays'

RSpec.describe "#stock_picker" do
  
    
  describe "rising prices" do
    it "returns the first and last days" do
      expect(stock_picker([10,20,30,40,50])).to eq([0, 4])
    end
  end
  
  describe "dropping prices" do
    it "returns nil" do
      expect(stock_picker([50,40,30,20,10])).to be_nil
    end
  end
  
  describe "more noisy prices" do
    it "returns the best buy/sell dates" do
      expect(stock_picker([20, 30, 10, 40, 50])).to eq([2, 4])
    end
  end
    

  
end