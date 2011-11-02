require "set"
class SolutionDisposer
  attr_reader :possible_solutions
  attr_reader :current_possible_solutions

  def initialize solution_size, colors
    @solution_size = solution_size
    @colors = colors
    initialize_possible_solutions
    init_new_round
  end

  def add_solutions solutions
    solutions.each do |s|
      self.add s.code
    end
  end

  def add element, to_set = @current_possible_solutions
    if element.size != @solution_size || !element.is_a?(Array)
      #     puts "#{element} not correct"
    elsif has_not_expected_colors element
#      puts "not expected colors"
    else
      result = to_set.add? element
      #     puts "sd: #{element} already in the solution" unless result
    end
  end

  def include? code
    @possible_solutions.include? code
  end

  def find_all code
    candidates = @possible_solutions.to_a.sort
    found = candidates.find_all do |candidate|
      code.each_with_index do |current_color, i|
        if current_color
          if candidate[i] != current_color
            false
            break
          end
        end
        true
      end
    end
  end

  def init_new_round
    if @current_possible_solutions
      new_poss_solutions = Set.new
      @current_possible_solutions.each do |ps|
        if include? ps
          new_poss_solutions.add ps
        else
          #      puts "ps:#{ps} doesn't exist"
        end
      end
      @possible_solutions = new_poss_solutions
    end
    @current_possible_solutions = Set.new
  end

  def size_of_current_possible_solutions
    @current_possible_solutions.size
  end

  def solutions_to_s
      s = ""
      @possible_solutions.to_a.sort.each do |solution|
        sol = solution.collect { |c| c.to_s }.join " "
        s << "[" << sol << "]
"
      end
    s
  end


  private

  def initialize_possible_solutions
    @possible_solutions = Set.new
    create_all_possible_solutions do |solution|
      self.add solution, @possible_solutions
    end
  end

  def create_all_possible_solutions already_found = [], &block
    if already_found.size == @solution_size
      yield already_found

    else
      @colors.each do |c|
        new_already_found = Array.new already_found
        new_already_found << c
        create_all_possible_solutions new_already_found, &block
      end
    end
  end


  def has_not_expected_colors(element)
    element.each do |e|
      return true if !@colors.include? e if e
    end
    false
  end

end