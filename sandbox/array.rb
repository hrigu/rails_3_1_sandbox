a = %w{ a b c d e f }
b = %w{  b d f }
x = a.select {|e| ! b.include? e}

puts x
