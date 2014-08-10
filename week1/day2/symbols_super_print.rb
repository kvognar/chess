def super_print(string, options = {} )
  defaults = {
    times: 1,
    upcase: false,
    reverse: false
  }
  
  values = defaults.merge(options)
  
  result = string * values[:times]
 
  result = result.upcase if values[:upcase]

  result = result.reverse if values[:reverse]

  result
end

puts
puts super_print("Hello")
puts super_print("Hello", :times => 3)                       #=> "Hello" 3x
puts super_print("Hello", :upcase => true)                   #=> "HELLO"
puts super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

puts
