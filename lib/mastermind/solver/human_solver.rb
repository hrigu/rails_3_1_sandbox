
class HumanSolver

  attr_accessor :current_guess


  def initialize possible_colors, length_of_code = 4
    @possible_colors = possible_colors
    @length_of_code = length_of_code
  end

  def make_guess
    @current_guess
  end


end