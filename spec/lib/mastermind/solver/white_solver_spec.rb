require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/white_solver'

def find_solutions(guess, num_of_whites)
  solutions = [Solution.new(Array.new guess.size, nil)]

  #solution.mark_not_possible_solutions_after_black guess

  solutions = WhiteSolver.new.find_solutions(guess, num_of_whites, solutions)
  # p solutions
  solutions.to_set.size.should == solutions.size #no duplicates
  solutions
end

describe WhiteSolver do
  describe "code with no duplicates" do
    context "0 white" do
      context "1 color" do
        it "should have one solution" do
          array = %w[a]
          solutions = find_solutions(array, 0)
          solutions.size.should == 1
          s = solutions[0]
          s.code.should == [nil]
          s.not_possible_colors[0].should correlate %w[a]
        end
      end
      context "2 color" do
        it "should have one solution" do
          array = %w[a b]
          solutions = find_solutions(array, 0)
          solutions.size.should == 1
          s = solutions[0]
          s.code.should == [nil, nil]
          s.not_possible_colors[0].should correlate %w[a b]
          s.not_possible_colors[1].should correlate %w[a b]
        end
      end
    end

    context "1 white" do
      before :all do
        @num_of_white = 1
      end

      context "1 color" do
        it "should have 0 solutions" do
          array = %w[a]
          solutions = find_solutions(array, @num_of_white)
          solutions.size.should == 0
        end
      end

      it "2 colors" do
        array = %w[a b]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 2
        solutions.should contain [nil, "a"]
        solutions.should contain ["b", nil]

        s = Solution.find solutions, [nil, "a"]
        s.not_possible_colors[0].to_a.should =~ %w[b]
        s.not_possible_colors[1].should be_nil

        s = Solution.find solutions, ["b", nil]
        s.not_possible_colors[0].should be_nil
        s.not_possible_colors[1].to_a.should =~ %w[a]
      end

      it "3 colors" do
        array = %w[a b c]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 6
        solutions.should contain [nil, "a", nil]
        solutions.should contain [nil, nil, "a"]
        solutions.should contain ["b", nil, nil]
        solutions.should contain [nil, nil, "b"]
        solutions.should contain ["c", nil, nil]
        solutions.should contain [nil, "c", nil]
      end
    end

    context "2 white" do
      before :all do
        @num_of_white = 2
      end
      it "1 color" do
        array = %w[a]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 0
      end
      context "2 colors" do
        it "normal" do
          array = %w[a b]
          solutions = find_solutions(array, @num_of_white)
          solutions.size.should == 1
          solutions.should contain ["b", "a"]
        end

      end
      context "3 colors" do
        it "normal" do
          array = %w[a b c]
          solutions = find_solutions(array, @num_of_white)
          solutions.size.should == 9
          p solutions
          solutions.should contain ["b", "a", nil]
        end
        
        it "already one black" do
          guess = %w[a b c]
          solutions = [Solution.new(["a", nil, nil])]

          solutions = WhiteSolver.new.find_solutions(guess, @num_of_white, solutions)
          
          
          p solutions
          
          solutions.size.should == 1
          
        end
        
      end
      it "should have 1 solution" do
        array = %w[a a c c]
        solutions = find_solutions(array, 4)
        p solutions
        solutions.size.should == 1
        solutions.should contain %w[c c a a]
      end
    end
    context "3 white" do
      before :all do
        @num_of_white = 3
      end
      it "1 color" do
        array = %w[a]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 0
      end
      it "2 colors" do
        array = %w[a b]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 0
      end
      it "3 colors" do
        array = %w[a b c]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 2
        solutions.should contain ["c", "a", "b"]
        solutions.should contain ["b", "c", "a"]
      end
      it "4 colors" do
        guess = %w[a b c d]
        solutions = find_solutions(guess, @num_of_white)
        solutions.size.should == 44
        solutions.should contain ["c", "a", "b", nil]
        solutions.should contain ["b", "c", "a", nil]
        solutions.should contain ["b", "c", "d", nil]
        s = Solution.find solutions, ["b", "c", "d", nil]
        s.not_possible_colors[3].should correlate ["a"]
      end
    end
    context "4 white" do
      before :all do
        @num_of_white = 4
      end
      it "4 colors" do
        array = %w[a b c d]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 9
        solutions.should contain ["c", "a", "d", "b"]
        solutions.should contain ["b", "c", "d", "a"]
      end

      it "two doule colors" do
        array = %w[a a c c]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 1
        solutions.should contain %w[c c a a]
      end
    end


  end

  describe "code with duplicates" do
    context "num_of_white = 1, [a, a]" do
      before :all do
        @num_of_white = 1
      end
      it "1 color" do
        array = %w[a a]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 0
      end
    end
    context "num_of_white = 1, code_length = 3" do
      before :all do
        @num_of_white = 1
      end
      it "[a b b]" do
        array = %w[a b b]
        solutions = find_solutions(array, @num_of_white)
        p solutions
        solutions.size.should == 3
      end
      it "[a a b]" do
        array = %w[a a b]
        solutions = find_solutions(array, @num_of_white)
        solutions.size.should == 3
      end
    end
    context "num_of_white = 1, code_length = 4" do
      before :all do
        @num_of_white = 1
      end
      it "[b a a c]" do
        array = %w[b a a c]
        solutions = find_solutions(array, @num_of_white)
        #p solutions
        solutions.size.should == 8
      end
    end
  end

end



