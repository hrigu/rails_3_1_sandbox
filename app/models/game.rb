$game_instances ||= {}
$game_next_id  ||=0;

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
    @strategy = ComputerAgainstHumanStrategy.new self
  end

  def start
    @strategy.start
  end

  def guess args
    @strategy.guess args
  end

  def self.find id
    $game_instances[id]
  end

end

class ComputerAgainstHumanStrategy
  def initialize game
    @game = game
  end

  def start
    @mastermind = Mastermind.new @game.colors, @game.size_of_code
  end

  def guess args
    guess = Array.new size_of_code
    args.each_pair { |key, value| guess[key.to_i] = value }
    @game.solved = @mastermind.guess guess
  end

end