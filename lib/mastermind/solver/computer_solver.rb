
require File.dirname(__FILE__) + '/white_solver'
require File.dirname(__FILE__) + '/black_solver'
require File.dirname(__FILE__) + '/empty_positions_filler'
require File.dirname(__FILE__) + '/solution_disposer'
require File.dirname(__FILE__) + '/guess_strategy'

class ComputerSolver

  def initialize possible_colors, length_of_code = 4
    @possible_colors = possible_colors
    @white_solver = WhiteSolver.new
    @black_solver = BlackSolver.new
    @empty_positions_filler = EmptyPositionsFiller.new possible_colors
    @length_of_code = length_of_code
    @solution_disposer = SolutionDisposer.new length_of_code, @possible_colors
    @guess_strategy = GuessStrategy.new
  end

  def make_guess
    @guess_strategy.make_guess(@solution_disposer)
  end

  def include? code
    @solution_disposer.include? code
  end

  def reduce_solutions guess

    possible_solutions = @black_solver.find_solutions guess.code, guess.num_of_blacks
    possible_solutions = @white_solver.find_solutions guess.code, guess.num_of_whites, possible_solutions
    possible_solutions = @empty_positions_filler.fill_empty_positions(possible_solutions)


    @solution_disposer.add_solutions possible_solutions
    @solution_disposer.init_new_round

  end

  def possible_solutions
    @solution_disposer.possible_solutions.to_a
  end


  private


end