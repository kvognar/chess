require 'debugger'
def range(start, finish)
  if finish < start
    return []
  end
  
  result = [start]
  result += range(start + 1, finish)
end

def sum_arr(arr)
  result = 0
  
  arr.each do |num|
    result += num
  end
  
  result
end

def recursive_sum_array(arr)
  if arr.empty?
    return 0
  end
  
  result = arr.first
  result += recursive_sum_array(arr[1..-1])
end

def exp1(num, power)
  return 1 if power == 0
  
  num * exp1(num, power-1)
end

def exp2(num, power)
  return 1 if power == 0
  
  return exp2(num, power / 2) * exp2(num, power / 2) if power.even?
  num * (exp2(num, (power - 1) / 2) ** 2)  
end

class Array
  def deep_dup
    result = []
    self.each do |element|
       if element.is_a?(Array)
         result << element.deep_dup
       else
         result << element
       end
    end
    result
  end
end

def fibonacci_iterator(n)
  return [] if n == 0
  return [0] if n == 1
  
  result = [0, 1]
  
  while n > result.count
    result << result[-1] + result[-2]
  end
  result
  
end

def fibonacci_recursive(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2
  
  result = fibonacci_recursive(n -1)
  result << result[-1] + result[-2]
end

def bsearch(array, target)
  return nil if target > array.last
  return nil if target < array.first
  halfway_point = array.count / 2
  
  if array[halfway_point] < target
    bsearch_result = bsearch(array[halfway_point..-1], target)
    return bsearch_result if bsearch_result.nil?
    return bsearch(array[halfway_point..-1], target) + halfway_point
  elsif array[halfway_point] > target
    return bsearch(array[0..halfway_point], target) 
  end
  halfway_point
end

def make_change_the_american_way(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  
  change = []
  num_big_coins = amount / coins.first
  num_big_coins.times { change << coins.first }
  amount -= num_big_coins * coins.first
  
  change += make_change(amount, coins[1..-1])
  p change
  change                                        
end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  
  change = []
  num_big_coins = amount / coins.first
  if num_big_coins > 0
    change << coins.first
    amount -= coins.first
    change += make_change(amount, coins[0..-1])
  else
    change += make_change(amount, coins[1..-1])
  end
  p change
  change           
end
  
def make_min_coins(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  
  big_change = []
  small_change = []
  big_amount = amount
  small_amount = amount
  
  if amount / coins.first > 0
    big_change << coins.first
    big_amount -= coins.first
    big_change += make_min_coins(big_amount, coins[0..-1])
  else
    big_change += make_min_coins(big_amount, coins[1..-1])
  end
  
  return big_change if coins.count == 1
  
  if amount / coins[1] > 0
    small_change << coins[1]
    small_amount -= coins[1]
    small_change += make_min_coins(small_amount, coins[1..-1])
  else
    small_change += make_min_coins(small_amount, coins[2..-1])
  end
  
  return big_change if big_change.count < small_change.count
  small_change         
end
  
def merge_sort(arr)
  return arr if arr.length <= 1
  
  arr1, arr2 = arr[0...(arr.length / 2)], arr[(arr.length / 2)..-1]
  arr1 = merge_sort(arr1)
  arr2 = merge_sort(arr2)
  merge(arr1, arr2)
end  
  
def merge(arr1, arr2)
  result = []
  return arr1 + arr2 if arr1.empty? || arr2.empty?
  if arr1.first < arr2.first
    result << arr1.shift
  else 
    result << arr2.shift
  end
  p result
  result += merge(arr1, arr2)
end

# p merge_sort([38, 27, 43, 3, 9, 82, 10])

def subsets_iterated(array)
  n = 2 ** array.length
  
  subsets = []
  
  n.times do |i|
    subset = []
    binary = (i+ n).to_s(2)
    binary = binary[1..-1]
    p binary
    binary.split('').each_with_index do |num, index|
      subset << array[index] if num == "1"
    end
    subsets << subset
  end
  
  subsets
end

def subsets_weird(array)
  subsets = [[]]
  return [[]] if array.count == 0
  
  subsets << array
  array.count.times do |i|
    doop = array.dup
    doop.delete_at(i)
    subsets += subsets_recursive(doop) - [[]]
  end
  
  subsets
end


def subsets(array)
  return [[]] if array.empty?
  old_subsets = subsets(array[0..-2])
  new_subsets = old_subsets.deep_dup
  new_subsets = new_subsets.map{ |set| set << array.last }
  old_subsets + new_subsets
end

# p  subsets_weird([1, 2, 3])
p subsets([1,2,3])
# p subsets_iterated([1, 2, 3, 4, 5, 6, 7])



