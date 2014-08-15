class Array
  
  def my_uniq
    result = []
    self.each { |element| result << element unless result.include?(element) }
    result
  end
  
  def two_sum
    results = []
    self.each_with_index do |el1, index1|
      (index1 + 1 ... self.length).each do |index2|
        results << [index1, index2] if self[index1] + self[index2] == 0
      end
    end
    results
  end
  
end