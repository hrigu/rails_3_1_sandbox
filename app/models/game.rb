$game_instances ||= {}
$game_next_id ||=0;

class Game
  attr_reader :player_values, :code_sizes, :color_sizes
  attr_reader :master, :solver, :size_of_code, :num_of_colors, :colors
  attr_accessor :solved
  attr_reader :id


  def initialize
    @player_values = %w[Computer Mensch]
    @master = @player_values[0]
    @solver = @player_values[1]
    @code_sizes = %w[1 2 3 4 5 6]
    @color_sizes = %w[1 2 3 4 5 6 7 8]
    @size_of_code = @code_sizes[3].to_i
    @num_of_colors = @color_sizes[5].to_i

    @id = $game_next_id
    $game_instances[@id] = self

    $game_next_id += 1
  end

  def properties= options = {master: "Computer", solver: "Mensch", size_of_code: "4", num_of_colors: "6"}
    @master, @solver = options[:master], options[:solver]
    @size_of_code, @num_of_colors = options[:size_of_code].to_i, options[:num_of_colors].to_i
    @colors = %w[green yellow blue red magenta black white orange][0, num_of_colors]
    @solved = false

    if master == "Computer"
      if solver == "Mensch"
        @strategy = ComputerAgainstHumanStrategy.new self
      else
        @strategy = HumanAgainstComputerStrategy.new self
      end
    else
      if solver == "Mensch"
        @strategy = HumanAgainstComputerStrategy.new self
      else
        @strategy = HumanAgainstComputerStrategy.new self
      end
    end
  end

  def start
    @strategy.start
  end

  def guess args = nil
    @strategy.guess args
  end

  def possible_solutions
    @strategy.possible_solutions
  end

  def self.find id
    $game_instances[id]
  end

  def self.delete id
    $game_instances.each do |key, value|
      puts key
    end
    $game_instances.delete id
    $game_instances.each do |key, value|
      puts key
    end
  end


  def mastermind
    @strategy.mastermind if @strategy
  end

end

class GameStrategy
  attr_reader :mastermind

  def initialize game
    @game = game
  end

  def start
    @mastermind = Mastermind.new @game.colors, @game.size_of_code
  end

  def possible_solutions
    []
  end
end

class ComputerAgainstHumanStrategy < GameStrategy


  def guess args
    guess = Array.new @game.size_of_code
    args.each_pair { |key, value| guess[key.to_i] = value }
    @game.solved = @mastermind.guess guess
  end

end

class HumanAgainstComputerStrategy < GameStrategy

  def start
    super
    @solver = Solver.new @game.colors, @game.size_of_code
    @current_guess = @solver.make_guess
  end

  def guess args = nil
    @current_guess = @solver.make_guess

    puts @current_guess.inspect
    @game.solved = @mastermind.guess @current_guess
    unless @game.solved
      @solver.reduce_solutions @mastermind.current_guess
    else
      @solver = nil     #to save memory
    end
  end

  def possible_solutions
    @solver.possible_solutions
  end

end