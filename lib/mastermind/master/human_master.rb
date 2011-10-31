require File.dirname(__FILE__) + '/../board/board'

class HumanMaster
  attr_reader :solved
  attr_accessor :secret_code

  ##
  # an array with two elements: num of blacks, num_of_whites
  ##
  attr_writer :evaluation

  def initialize board
    @board = board
  end



  def evaluate guess
    @solved = @evaluation[0] == @board.num_of_elements ? true : false
    @evaluation
  end
end
