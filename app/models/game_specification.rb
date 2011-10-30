class GameSpecification

  attr_reader :player_values, :code_sizes, :color_sizes
  attr_reader :master, :solver, :size_of_code, :num_of_colors
  attr_reader :colors
  attr_accessor :id

  def initialize map = nil

    @player_values = %w[Computer Mensch]
    @code_sizes = %w[1 2 3 4 5 6]
    @color_sizes = %w[1 2 3 4 5 6 7 8]
    map ||= {master: "Computer", solver: "Mensch", size_of_code: 4, num_of_colors: 6}
    choose map

    GameHolder.add_spec(self)
  end

  #{:master => "Computer", :solver => "Computer", :size_of_code => "4", :num_of_colors => "6"}
  def choose map
    @master = map[:master]
    @solver = map[:solver]
    @size_of_code, @num_of_colors = map[:size_of_code].to_i, map[:num_of_colors].to_i


    @colors = %w[green yellow blue red magenta black white orange][0, @num_of_colors]
    self
  end

end
