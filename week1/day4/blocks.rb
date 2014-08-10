class Array
  def my_each(&block)
    count.times do |index|
      block.call(self[index])
    end
  end
  
  def my_map(&block)
    result = []
    my_each { |i| result << block.call(i) }
    result
  end
  
  def my_select(&block)
    result = []
    my_each { |i| result << i if block.call(i)}
    result
  end
  
  def my_inject(&block)
    first_el = self.first
    self[1...self.count].my_each { |i| first_el = block.call(first_el, i)}
    first_el
  end
  
  def my_sort!(&block)
    sorted = true
    while sorted
      sorted = false
      count.times do |index|
        comparison = block.call(self[index], self[index + 1])
        if comparison == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          sorted = true
        end
      end
    end
    self
  end
  
  def my_sort(&block)
    result = self.dup.my_sort!(&block)
  end
end

def eval_block(*args, &block)
  unless block_given?#if block.nil?
    puts "NO BLOCK GIVEN"
  else
    block.call(*args)
  end
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end

eval_block(1,2,3,4,5) do |*args|
  p args.inject(:+)
end

eval_block(1, 2, 3)
