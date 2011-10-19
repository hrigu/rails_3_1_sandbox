require File.dirname(__FILE__) + '/mastermind'

require File.dirname(__FILE__) + '/solver/white_solver'
require File.dirname(__FILE__) + '/solver/black_solver'
require File.dirname(__FILE__) + '/solver/solution_disposer'
require File.dirname(__FILE__) + '/solver/guess_strategy'
class Solver

  def initialize possible_colors, length_of_code = 4
    @possible_colors = possible_colors
    @white_solver = WhiteSolver.new
    @black_solver = BlackSolver.new
    @length_of_code = length_of_code
    @solution_disposer = SolutionDisposer.new length_of_code, @possible_colors
    @guess_strategy = GuessStrategy.new
  end

  def make_guess
    @guess_strategy.make_guess(@solution_disposer)
  end

  def include?   code
    @solution_disposer.include? code
  end

  def reduce_solutions guess

    ps = @black_solver.find_solutions guess.code, guess.num_of_blacks

    ps.each do |p|
      p.set_not_possible_colors guess.code
    end

    ps = @white_solver.find_solutions guess.code, guess.num_of_whites, ps



    num_of_not_evalutated_elements = @length_of_code - (guess.num_of_blacks + guess.num_of_whites)
    possible_colors = @possible_colors
    ps = fill_empty_positions(guess.code, ps)
    @solution_disposer.add_solutions ps
    @solution_disposer.init_new_round

  end

  def possible_solutions
    @solution_disposer.possible_solutions.to_a
  end

  private


  def fill_empty_positions(code, current_solutions)
    possible_solutions = []
    current_solutions.each do |current_solution|
      empty_position_indices = find_empty_position_indices(current_solution)
      case empty_position_indices.size
        when 0
          possible_solutions << current_solution
        else
          possible_colors = create_possible_colors code, current_solution.not_possible_colors
          permute empty_position_indices.size, possible_colors do |permutation|
            s = create_new_solution(permutation, empty_position_indices, Array.new(current_solution))
            possible_solutions << s
#              possible_solutions << p_s if num_of_exact_matches(p_s, code) == 0 && !possible_solutions.include?(p_s)
          end
      end
    end
    possible_solutions
  end

  def create_new_solution(permutation, empty_position_indices, current_solution)
    #  p permutation
    empty_position_indices.each_with_index do |index_in_current_solution, i|
      current_solution[index_in_current_solution] = permutation[i]
    end
    #   p current_solution
    current_solution
  end


  def create_possible_colors(code, not_included_colors)
    #@possible_colors
    possible_colors = Array.new @possible_colors
    not_included_colors.each do |color|
      possible_colors.delete color
    end
    possible_colors
  end

  def permute max_depth = 2, possible_colors = @possible_colors, current_depth = max_depth, sol = [], &args
    if (current_depth == 0)
      yield sol
    else
      possible_colors.each do |p|
        sol_new = Array.new sol
        sol_new << p
        permute max_depth, possible_colors, current_depth - 1, sol_new, &args
      end
    end
  end

  def find_empty_position_indices(found)
    empty_places = []
    found.each_with_index do |f, i|
      empty_places << i unless f
    end
    empty_places
#    found.original_positions
  end
end