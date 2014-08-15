require 'rspec'
require 'arrays'

RSpec.describe(Array) do
  
  describe "#my_uniq" do
    it "should return unique elements" do
      expect([1, 2, 1, 3, 3].my_uniq).to eq([1, 2, 3])
    end
  end
  
end