puts "Mastermind: before require"
require File.dirname(__FILE__) + '/board/board'
require File.dirname(__FILE__) + '/solver/computer_solver'
require File.dirname(__FILE__) + '/solver/human_solver'
require File.dirname(__FILE__) + '/master/computer_master'


class Mastermind

  attr_reader :board
  attr_accessor :master, :solver

  def initialize possible_colors = [:a, :b, :c, :d], num_of_elements = 4
    @board = Board.new possible_colors, num_of_elements
  end


  def play
    hidden_code = master.build_secret_code
    board.hidden_code = hidden_code
    begin
      master.solved
      guess = solver.make_guess
      board.guess = guess
      eval = master.evaluate guess
      board.eval = eval
    end until master.solved
  end
end