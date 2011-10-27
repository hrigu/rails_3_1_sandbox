
module Helper
  def convert_to_s code
    code.collect { |c| c.to_s }.join " "
  end
end

class Board
  attr_reader :guesses, :possible_colors, :num_of_elements
  attr_accessor :hidden_code

  def initialize possible_colors, num_of_elements = 4
    @possible_colors = possible_colors
    @num_of_elements = num_of_elements
    @guesses = []
  end

  def num_of_guesses
    @guesses.size
  end

  def all_guesses_to_s
    s = ""
    @guesses.each do |guess|
      s << guess.to_s << "/n"
    end
  end

  def guess= guess
    @guesses << Guess.new(guess)
  end

  def eval= eval
    @guesses.last.num_of_blacks = eval[0]
    @guesses.last.num_of_whites = eval[1]
  end

  def current_guess
    @guesses.last
  end

end


class Guess

  include Helper

  attr_accessor :code
  attr_accessor :num_of_blacks, :num_of_whites

  def initialize values
    @code = values
    @num_of_blacks, @num_of_whites = 0, 0
  end

  def to_s
    "#{convert_to_s @code}: [#{num_of_blacks},#{num_of_whites}]"
  end


end
