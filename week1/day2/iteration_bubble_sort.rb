def bubble_sort(array)
  sorted = true
  
  while sorted
    sorted = false
    (array.length - 1).times do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = true
      end
    end
  end
  
  array
end

puts
puts bubble_sort([5, 4, 3, 2, 1])
puts