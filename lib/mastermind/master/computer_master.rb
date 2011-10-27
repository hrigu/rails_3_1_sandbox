require File.dirname(__FILE__) + '/../board/board'

class ComputerMaster
  attr_reader :solved
  attr_accessor :secret_code
  def initialize board
    @board = board
    @evaluator = Evaluator.new
  end

  def build_secret_code
    secret_code = []
    @board.num_of_elements.times do
      r = Random.rand @board.possible_colors.size
      secret_code << @board.possible_colors[r]
    end
    @secret_code = secret_code
  end

  def evaluate guess
    result = @evaluator.evaluate(@secret_code, guess)
    @solved = result[0] == @board.num_of_elements ? true : false
    result
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
