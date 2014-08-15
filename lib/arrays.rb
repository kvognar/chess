class Array
  
  def my_uniq
    result = []
    self.each { |element| result << element unless result.include?(element) }
    result
  end
  
end