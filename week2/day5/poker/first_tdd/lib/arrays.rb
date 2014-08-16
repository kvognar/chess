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

def stock_picker(prices)
  best_profit = 0
  best_days = nil
  prices.each_with_index do |price1, day1|
    (day1 + 1 ... prices.length).each do |day2|
      profit = prices[day2] - price1
      if profit > best_profit
        best_days = [day1, day2] 
        best_profit = profit
      end
    end # day2
  end # day1
  
  best_days
end
