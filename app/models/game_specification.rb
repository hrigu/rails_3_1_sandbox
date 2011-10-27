class GameSpecification

  attr_reader :player_values, :code_sizes, :color_sizes
  attr_reader :master, :solver, :size_of_code, :num_of_colors
  attr_reader :colors
  attr_accessor :id
  def initialize

    @player_values = %w[Computer Mensch]
    @code_sizes = %w[1 2 3 4 5 6]
    @color_sizes = %w[1 2 3 4 5 6 7 8]


    @master = @player_values[0]
    @solver = @player_values[1]
    @size_of_code = @code_sizes[3].to_i
    @num_of_colors = @color_sizes[5].to_i

     GameHolder.add_spec(self)
  end

  #{:master => "Computer", :solver => "Computer", :size_of_code => "4", :num_of_colors => "6"}
  def choose= map
    @master = map[:master]
    @solver = map[:solver]
    @size_of_code, @num_of_colors = map[:size_of_code].to_i, map[:num_of_colors].to_i
    @colors = %w[green yellow blue red magenta black white orange][0, num_of_colors]
    self
  end

end
