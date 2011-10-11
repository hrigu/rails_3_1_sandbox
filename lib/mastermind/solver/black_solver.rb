require File.dirname(__FILE__) + '/solution'

class BlackSolver

  def find_solutions code, num_of_blacks, fixed_pos = Array.new(code.size);
    solutions = []
    positions = Array.new(code.size){|i| i}
    permute positions, num_of_blacks do |permutation|
      solution = Solution.new fixed_pos
      permutation.each {|p| solution[p] = code[p]}
      solutions << solution
    end
    solutions
  end

  private

  def permute positions, max_depth = 1, depth = 0, current_pos = 0, already_found = Array.new(max_depth), &args
    if (depth == max_depth)
      yield already_found
    else
      (current_pos ..positions.size-1).each do |pos_index|
        result = Array.new already_found
        result[depth] = positions[pos_index]
        permute(positions, max_depth, depth + 1, pos_index + 1, result, &args)
      end
    end
  end


end