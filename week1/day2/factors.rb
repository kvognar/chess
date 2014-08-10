def factors(num)
  (1..num).to_a.select { |i| num % i == 0 }
end

puts factors(250)