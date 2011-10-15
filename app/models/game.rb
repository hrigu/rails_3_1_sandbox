class Game
  attr_reader :player_values, :code_sizes, :color_sizes
  attr_accessor :master, :solver, :size_of_code, :num_of_colors
  attr_reader :mastermind, :solved, :colors #, :solver

  def initialize
    @player_values = %w[Computer Mensch]
    @master = @player_values[0]
    @solver = @player_values[1]
    @code_sizes = %w[1 2 3 4 5 6]
    @color_sizes = %w[1 2 3 4 5 6 7 8]
    @size_of_code = @code_sizes[3].to_i
    @num_of_colors = @color_sizes[5].to_i
  end

  def properties= options = {master: "Computer", solver: "Mensch", size_of_code: "4", num_of_colors: "6"}
    @master, @solver = options[:master], options[:solver]
    @size_of_code, @num_of_colors = options[:size_of_code].to_i, options[:num_of_colors].to_i
    @solved = false
  end

  def start
    @colors = %w[green yellow blue red magenta black white orange][0, num_of_colors]
    @mastermind = Mastermind.new @colors, size_of_code
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