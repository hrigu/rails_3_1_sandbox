require "set"

class Solution

  attr_reader :code

  ##
  # an array of sets for each position on which the color is not fixed yet
  ##
  attr_reader :not_possible_colors

  def initialize arg
    if arg.is_a? Solution
      @code = Array.new arg.code
      @not_possible_colors = deep_copy arg.not_possible_colors
    elsif arg.is_a? Array
      @code = Array.new arg
      @not_possible_colors = Array.new @code.size, nil
      @code.each_with_index do |e, i|
        @not_possible_colors[i] = Set.new unless e
      end
    else
      puts "Solution: do not understand arg: #{arg}"
    end

  end

  def add_color_at(color, i)
    code[i] = color
    not_possible_colors[i] = nil
  end

  def add_not_possible_color_at(color, i)

    not_possible_colors[i] << color unless code[i]
  end

  #TODO better name: add_not_possible_colors_after_black
  def mark_not_possible_solutions_after_black guess
    @code.each_with_index do |e, i|
      unless e
        not_possible_colors_for_pos = @not_possible_colors[i]
        unless not_possible_colors_for_pos
          not_possible_colors_for_pos = Array.new
          @not_possible_colors[i] = not_possible_colors_for_pos
        end
        not_possible_colors_for_pos << guess[i]
      end
    end
  end

  def add_not_used_colors_to_the_not_possible_colors guess
    #not_used_colors = guess - code.compact
    not_used_colors = []
    colors_of_solution = code.compact
    guess_color = Array.new guess

    guess_color.each do |gc|
      used_color = colors_of_solution.delete_at colors_of_solution.index(gc) unless colors_of_solution.index(gc).nil?
      not_used_colors << gc if used_color.nil?
    end


    #not_used_colors = []
    #code.each_with_index do |c, i|
    #  not_used_colors << guess[i] unless c
    #end
    not_used_colors.each do |c|
      not_possible_colors.each do |not_possible_color|
        not_possible_color << c if not_possible_color
      end
    end
  end


  def inspect
    "#{code.inspect} - #{not_possible_colors.inspect}"
  end

  def to_s
    code.inspect
  end

  def eql?(other)
    self.code == other.code && self.not_possible_colors == other.not_possible_colors
  end

  def hash
    [self.code.hash, self.not_possible_colors].hash
  end

  def self.find(solutions, code)
    solutions.each do |solution|
      return solution if solution.code == code
    end
    nil
  end

  private

  def deep_copy array

    return nil unless array

    copy = Array.new array.size, nil

    array.each_with_index do |e, i|
      copy[i] = Set.new(e) if e
    end
    copy
  end
end