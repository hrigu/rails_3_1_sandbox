class GameConfiguration
  VALUES = ["Computer", "Mensch"]

  attr_reader :player_values, :code_sizes, :color_sizes
  attr_reader :master, :solver

  def initialize
    @player_values = VALUES
    @master = @player_values[0]
    @solver = @player_values[1]
    @code_sizes = %w[1 2 3 4 5 6]
    @color_sizes = %w[1 2 3 4 5 6 8 9]

  end
end