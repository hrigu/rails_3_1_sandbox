require "set"

class Solution < Array
  attr_reader :not_possible_colors
  def initialize(arg)
    super arg
    if arg.is_a? Solution
      @not_possible_colors = Set.new arg.not_possible_colors
    else
      @not_possible_colors = Set.new
    end

  end

  def set_not_possible_colors guess
    self.each_with_index do |element, index|
       unless element
        @not_possible_colors.add guess[index]
       end
    end
  end

  def remove_color_from_not_possible_colors color
    @not_possible_colors.delete color
  end


end