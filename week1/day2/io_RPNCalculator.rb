class RPN_Calculator
  def initialize
    @stacks = []    
  end
  
  def get_user_input
    puts "please enter an operator or operand: "
    user_input = gets.chomp
    if valid_input?(user_input)
      add_to_stack(user_input)
    else
      puts "Invalid input"
    end
  end
  
  def add_to_stack(user_input)
    @stacks << user_input
  end
  
  def valid_input?(user_input)
    numbers = %W[0 1 2 3 4 5 6 7 8 9]
    operators = %W[+ - / * = ]
    numbers.include?(user_input) || 
    (@stacks.size >= 2 && operators.include?(user_input))
  end
  
  def can_be_evaluated?(stack)
    operators = %W[+ - / *]
    operators.include?(stack.last) && stack.size >= 3
  end
    

  def evaluate(stack)
    operator = stack.pop.to_sym
    b = stack.pop.to_i
    a = stack.pop.to_i
    p [a, operator, b]
    stack.push(a.send(operator, b))
  end
    
  def get_answer
    evaluation_stack = []
    
    while @stacks.size >= 1
      evaluation_stack << @stacks.shift
      while can_be_evaluated?(evaluation_stack)
        evaluate evaluation_stack
        p evaluation_stack
      end
    end
    
    return evaluation_stack[0]
  end
        
  def main_loop
    puts "Hi, this is the RPNCalculator"
    puts "What would you like to calculate today?"

    until @stacks.last == "="
      get_user_input
      p @stacks
    end
    @stacks.pop

    puts get_answer
  end
  
  def read_file(filename)
    @stacks = File.read(filename).split(' ')
    puts get_answer
  end
  
end

if __FILE__ == $PROGRAM_NAME
  calculator = RPN_Calculator.new
  calculator.read_file(ARGV[0])
end