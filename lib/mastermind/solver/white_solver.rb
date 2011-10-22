require 'set'
require File.dirname(__FILE__) + '/solution'

class WhiteSolver

  ##
  #
  # @param guess
  ##
  def find_solutions guess, num_of_whites, already_found_solutions;
    if num_of_whites == 0
      already_found_solutions.each do |s|
        s.add_not_used_colors_to_the_not_possible_colors guess
      end
      return already_found_solutions
    end

    solutions = Set.new

    #TODO not neccessary?
    #already_found_solutions = [Solution.new(Array.new(guess.size))] if already_found_solutions.empty?

    already_found_solutions.each do |already_found_solution|
      already_set_positions = [] #set by black solver
      already_found_solution.code.each_with_index do |c, i|
        already_set_positions << i if c
      end

      permute_intern guess,already_set_positions, num_of_whites, 0, 0, already_found_solution do |solution|
        solution.add_not_used_colors_to_the_not_possible_colors guess
        solutions << solution

      end
    end
    solutions.to_a
  end

  private

  def permute_intern guess, already_set_positions, num_of_whites, current_white, current_pos, solution, &args
    if current_white == num_of_whites
      puts "permute_intern: found #{solution}"
      yield solution
    else
      find_new_possible_solutions(guess, already_set_positions, current_pos, solution) do |current_pos, new_solution|
        permute_intern(guess, already_set_positions, num_of_whites, current_white + 1, current_pos+1, new_solution, &args)
     end
    end
  end

  def find_new_possible_solutions(guess, already_set_positions, old_pos, solution)
    (old_pos ..guess.size-1).each do |current_pos|
      unless already_set_positions.find_index current_pos     #only there  is not already a color on current_pos (from a black pin)
        current_color = guess[current_pos]
        other_pos_indices = find_other_pos_indices current_color, guess, solution
        other_pos_indices.each do |i|
          result = Solution.new solution
          result.add_color_at(current_color, i)
          yield current_pos, result
        end
      end
    end
  end

  ##
  # find the indices of the possible targets for the color of the current position
  ##
  def find_other_pos_indices(current_color, code, possible_solution)
    other_pos_indices = []
    code.each_with_index do |e, i|
      unless possible_solution.code[i] || e == current_color || possible_solution.not_possible_colors.include?(current_color)
        other_pos_indices << i
      end
    end
    other_pos_indices
  end

end