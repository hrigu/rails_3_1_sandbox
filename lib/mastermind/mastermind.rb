
module Helper
  def convert_to_s code
    code.collect { |c| c.to_s }.join " "
  end
end

class Mastermind

  attr_reader :guesses, :possible_colors, :num_of_elements
  attr_accessor :code

  def initialize possible_colors, num_of_elements = 4
    @possible_colors = possible_colors
    @num_of_elements = num_of_elements
    #4 unique colors
    #@code = possible_colors.sample 4

    @code = []
    @num_of_elements.times do
    r = Random.rand @possible_colors.size
     @code << @possible_colors[r]
    end

    puts "code = #{code}"

    @guesses = []

    @evaluator = Evaluator.new
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

  # @param guess [An Array of colors]
  # returns true if the code is cracked
  def guess guess
    @guesses << Guess.new(guess)
    evaluate
  end

  def current_guess
    @guesses.last
  end

  private

  def evaluate
    result = @evaluator.evaluate(@code, current_guess.code)
    current_guess.num_of_blacks = result[0]
    current_guess.num_of_whites = result[1]
    current_guess.num_of_blacks == @num_of_elements ? true : false
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

class Evaluator

  def evaluate original_code, guess
    code = []
    rest_of_guess = []
    original_code.each do |color|
      code << [color, false]
    end

    num_of_blacks = 0
    num_of_whites = 0
    guess.each_with_index do |x, i|
      y = code[i]
      if x == y[0] then
        num_of_blacks += 1
        y[1] = true
      else
        rest_of_guess << x
      end

    end

    rest_of_guess.each do |x|
      candidate = code.find { |c| c[0] == x && !c[1] }
      if candidate then
        num_of_whites += 1
        candidate[1] = true
      end

    end
    [num_of_blacks, num_of_whites]
  end

end
