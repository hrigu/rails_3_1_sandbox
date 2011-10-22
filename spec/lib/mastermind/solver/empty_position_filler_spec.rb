require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/empty_positions_filler'
require File.expand_path(Rails.root) + '/lib/mastermind/solver/solution'


describe EmptyPositionsFiller do
  describe "fill_empty_position_for_solution" do
    before :each do
      @possible_colors = %w[a b]
      @filler = EmptyPositionsFiller.new @possible_colors
    end
    context "0 empty positions" do
      it "should return the same solution" do
        s = Solution.new ["a", "b", "b"]
        @filler.fill_empty_positions_for_solution s do |x|
          x.should be s
        end
      end
    end

    context "1 empty position" do
      context "0 possible color" do
        it "should return 0 solutions" do
          s = Solution.new [nil]
          s.add_not_possible_color_at("a", 0)
          s.add_not_possible_color_at("b", 0)
          found_solutions = []
          @filler.fill_empty_positions_for_solution s do |x|
            found_solutions << x
          end
          found_solutions.size.should == 0
#        p found_solutions
        end
      end
      context "1 possible colors" do
        it "should return the one solution" do
          s = Solution.new [nil]
          s.add_not_possible_color_at("a", 0)
          found_solutions = []
          @filler.fill_empty_positions_for_solution s do |x|
            found_solutions << x
          end
          found_solutions.size.should be 1
          found_solutions[0].code.should == %w[b]
#        p found_solutions
        end
      end
      context "2 possible colors" do
        it "should return two solution" do
          s = Solution.new [nil]
          #s.add_not_possible_color_at("a", 0)
          found_solutions = []
          @filler.fill_empty_positions_for_solution s do |x|
            found_solutions << x
            p x
          end
          found_solutions.size.should be 2
          found_solutions.should contain %w[a]
          found_solutions.should contain %w[b]
        end
      end
    end


    context "2 empty position" do
      context "both positions have 1 possible color" do
        it "should return 1 solution" do
          s = Solution.new [nil, nil]
          s.add_not_possible_color_at("a", 0)
          s.add_not_possible_color_at("a", 1)
          @filler.fill_empty_positions_for_solution s do |x|
            x.code.should == %w[b b]
          end
        end
      end
      context "one position 1 possible color, the other 2" do
        it "should return 2 solutions" do

          s = Solution.new [nil, nil]
          s.add_not_possible_color_at("a", 0)
          #s.add_not_possible_color_at("a", 1)
          solutions = []
          @filler.fill_empty_positions_for_solution s do |x|
            solutions << x
            p x
          end
          solutions.size.should be 2
          solutions.should contain %w[b a]
          solutions.should contain %w[b b]
          solutions.should_not contain %w[a b]

        end
      end
      context "both positions 2 colors" do
        it "should return 3 solutions" do
          s = Solution.new [nil, nil]
          solutions = []
          @filler.fill_empty_positions_for_solution s do |x|
            solutions << x
            p x
          end
          solutions.size.should be 4
          solutions.should contain %w[a a]
          solutions.should contain %w[a b]
          solutions.should contain %w[b a]
          solutions.should contain %w[b b]
        end

        context "with solution with 3 positions" do
          it "should return 3 solutions" do
            s = Solution.new [nil, "a", nil]
            solutions = []
            @filler.fill_empty_positions_for_solution s do |x|
              solutions << x
              p x
            end
            solutions.size.should be 4
            solutions.should contain %w[a a a]
            solutions.should contain %w[a a b]
            solutions.should contain %w[b a a]
            solutions.should contain %w[b a b]
          end
        end


      end
    end
  end

  describe "find_empty_positions" do
    before :each do
      @filler = EmptyPositionsFiller.new nil

    end
    context "one empty position" do
      it "should return one index" do
        indices = @filler.find_empty_position_indices ["a", "b", nil]
        indices.should == [2]
      end
    end
    context "two empty position" do
      it "should return two index" do
        indices = @filler.find_empty_position_indices ["a", "b", nil, nil]
        indices.should == [2, 3]
      end
    end
  end
end