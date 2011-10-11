class Game
  attr_accessor :master, :solver, :size_of_code, :num_of_colors
  attr_reader :mastermind, :solved #, :solver


  def initialize options = {master: "Computer", solver: "Human", size_of_code: "4", num_of_colors: "6"}
    @master, @solver = options[:master], options[:solver]
    @size_of_code, @num_of_colors = options[:size_of_code].to_i, options[:num_of_colors].to_i
    @solved = false
  end

  def start
    colors = %w[a b c d e f g h][0, num_of_colors]
    @mastermind = Mastermind.new colors, size_of_code
    #@solver = Solver.new colors, size_of_code
  end

  def guess args
    puts "ARRGS: #{args}"
    guess = Array.new size_of_code
    args.each_pair {|key, value| guess[key.to_i] = value }
    puts "GUESSSS#{guess.to_s}"
    @solved = mastermind.guess guess
  end
end