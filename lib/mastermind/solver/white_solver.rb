require 'set'
require File.dirname(__FILE__) + '/solution'

class WhiteSolver
  ##
  #
  # @param guess
  ##
  def find_solutions guess, num_of_whites, already_found_solutions = [];
    if (num_of_whites == 0)
      return already_found_solutions
    end
    solutions = Set.new
    already_found_solutions = [Array.new(guess.size)] if already_found_solutions.empty?
    already_found_solutions.each do |already_found_solution|
      permute_intern guess, num_of_whites, 0, 0, already_found_solution do |solution|
        solutions << solution
      end
    end
    solutions.to_a
  end

  private

  def permute_intern guess, max_depth = 1, depth = 0, old_pos = 0, possible_solution, &args
    if depth == max_depth
      yield possible_solution
    else
      find_new_possible_solutions(args, guess, depth, max_depth, old_pos, possible_solution) do |current_pos, possible_solution|
        #  p result
        permute_intern(guess, max_depth, depth + 1, current_pos+1, possible_solution, &args)

      end
    end
  end

  def find_new_possible_solutions(args, guess, depth, max_depth, old_pos, possible_solution)
    (old_pos ..guess.size-1).each do |current_pos|
      current_color = guess[current_pos]
#      if possible_solution[current_pos]
 #       yield current_pos, possible_solution
  #    else
        other_pos_indices = find_other_pos_indices current_color, guess, possible_solution
        # puts "permute: depth = #{depth}, current_color = #{current_color}, already_found = #{already_found}, other_pos = #{other_pos}"
        other_pos_indices.each do |i|
          result = Solution.new possible_solution
          result.remove_color_from_not_possible_colors current_color
          result[i] = current_color
          yield current_pos, result
        end
   #   end
    end
  end

  ##
  # find the indices of the possible targets for the color of the current position
  ##
  def find_other_pos_indices(current_color, code, possibleSolution)
    other_pos_indices = []
    code.each_with_index do |e, i|
      #puts "current_color: #{current_color} code_element: #{e}"
      unless possibleSolution[i] || e == current_color
        other_pos_indices << i
      end
    end
    other_pos_indices
  end

end