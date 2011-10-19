require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/white_solver'

def find_solutions(array, num_of_whites)
  solutions = WhiteSolver.new.find_solutions(array, num_of_whites)
 # p solutions
  solutions.to_set.size.should == solutions.size
  solutions
end

describe "find_solutions_for_white" do
  context "num_of_white = 1" do
    before :all do
      @num_of_white = 1
    end

    it "1 color" do
      array = %w[a]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 0
    end

    it "2 colors" do
      array = %w[a b]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 2
      solutions.should include [nil, "a"]
      solutions.should include ["b", nil]
    end

    it "3 colors" do
      array = %w[a b c]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 6
      solutions.should include [nil, "a", nil]
      solutions.should include [nil, nil, "a"]
      solutions.should include ["b", nil, nil]
      solutions.should include [nil, nil, "b"]
      solutions.should include ["c", nil, nil]
      solutions.should include [nil, "c", nil]
    end
  end

  context "num_of_white = 2" do
    before :all do
      @num_of_white = 2
    end
    it "1 color" do
      array = %w[a]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 0
    end
    it "2 colors" do
      array = %w[a b]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 1
      solutions.should include ["b", "a"]
    end
    it "3 colors" do
      array = %w[a b c]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 9
      # p solutions
      #solutions.should include ["b", "a"]
    end
    it "should have 1 solution" do
      array =  %w[a a c c]
      solutions = find_solutions(array, 4)
      solutions.size.should == 1
      solutions.should include %w[c c a a]
    end
  end
  context "num_of_white = 3" do
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
      solutions.should include ["c", "a", "b"]
      solutions.should include ["b", "c", "a"]
    end
    it "4 colors" do
      array = %w[a b c d]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 44
      solutions.should include ["c", "a", "b", nil]
      solutions.should include ["b", "c", "a", nil]
    end
  end
  context "num_of_white = 4" do
    before :all do
      @num_of_white = 4
    end
    it "4 colors" do
      array = %w[a b c d]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 9
      solutions.should include ["c", "a", "d", "b"]
      solutions.should include ["b", "c", "d", "a"]
    end

    it "two doule colors" do
      array =  %w[a a c c]
      solutions = find_solutions(array, @num_of_white)
      solutions.size.should == 1
      solutions.should include %w[c c a a]
    end
  end


end

describe "find solutions for code with duplicate colors" do
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





