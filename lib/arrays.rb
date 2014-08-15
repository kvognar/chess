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

def my_transpose(matrix)
  results = Array.new(matrix.length) { Array.new(matrix.length) }
  (0...matrix.length).each do |row|
    (0...matrix.length).each do |col|
      results[col][row] = matrix[row][col]
    end
  end
  results
end

