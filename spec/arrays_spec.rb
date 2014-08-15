require 'rspec'
require 'arrays'

RSpec.describe(Array) do
  
  describe "#my_uniq" do
    it "should return unique elements" do
      expect([1, 2, 1, 3, 3].my_uniq).to eq([1, 2, 3])
    end
  end
  
  describe "#two_sum" do
    it "should return index pairs that sum to zero" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
  end
end
