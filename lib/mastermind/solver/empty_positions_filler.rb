class EmptyPositionsFiller

   def initialize possible_colors
     @possible_colors = possible_colors
   end

   def fill_empty_positions(current_solutions)
     possible_solutions = []
     current_solutions.each do |current_solution|
       fill_empty_positions_for_solution current_solution do |new_solution|
         possible_solutions << new_solution
       end
     end
     possible_solutions
   end


   def fill_empty_positions_for_solution(solution)
     empty_position_indices = find_empty_position_indices(solution.code)
     case empty_position_indices.size
       when 0
         yield solution
       else
         permute empty_position_indices, solution do |permutation|
           yield Solution.new permutation
         end
     end
   end


   def permute empty_position_indices, original_solution, current_depth = 0, new_solution = Array.new(original_solution.code), &args
     current_index = empty_position_indices[current_depth]
     if current_depth == empty_position_indices.size
       yield new_solution
     else
       possible_colors = create_possible_colors(original_solution.not_possible_colors[current_index])
       possible_colors.each do |p|
         sol_new = Array.new new_solution
         sol_new[current_index] =  p
         permute empty_position_indices, original_solution, current_depth + 1, sol_new, &args
       end
     end
   end

   def find_empty_position_indices(code)
     empty_places = []
     code.each_with_index do |f, i|
       empty_places << i unless f
     end
     empty_places
 #    found.original_positions
   end

   def create_new_solution(permutation, empty_pos_indices, current_solution)
     #  p permutation
     empty_pos_indices.each_with_index do |index_in_current_solution, i|
       current_solution[index_in_current_solution] = permutation[i]
     end
     #   p current_solution
     current_solution
   end
   def create_possible_colors(not_included_colors)
     #@possible_colors
     possible_colors = Array.new @possible_colors
     not_included_colors.each do |color|
       possible_colors.delete color
     end
     possible_colors
   end


end