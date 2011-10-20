require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/black_solver'

describe BlackSolver do
  context "two positions, guess = [a b]" do
    context "zero black" do
      it "should find one solution, [nil nil]" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b], 0
        solutions.size.should == 1
        solutions.should include [nil, nil]
      end
    end
    context "one black" do
      it "should find two solutions, [a nil] and [nil b]" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b], 1
        solutions.size.should == 2
        solutions.should include ["a", nil]
        solutions.should include [nil, "b"]
      end
    end
    context "two black" do
      it "should find one solution, [a b]" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b], 2
        solutions.size.should == 1
        solutions.should include ["a", "b"]
      end
    end
  end
  context "four positions, guess = [a b c d]" do
    context "one black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 1

        solutions.size.should == 4
        solutions.should include ["a", nil, nil, nil]
        solutions.should include [nil, "b", nil, nil]
        solutions.should include [nil, nil, "c", nil]
        solutions.should include [nil, nil, nil, "d"]
      end
    end
    context "two black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 2
        solutions.size.should == 6
        solutions.should include ["a", "b", nil, nil]
        solutions.should include [nil, "b", "c", nil]
        solutions.should include [nil, nil, "c", "d"]
        solutions.should include ["a", nil, nil, "d"]

        #not
        solutions.should_not include ["a", "b", nil, "d"]
        solutions.should_not include ["a", nil, "b", nil]
      end
    end
    context "three black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 3
        solutions.size.should == 4

        solutions.should include ["a", "b", "c", nil]
        solutions.should include ["a", nil, "c", "d"]


      end
    end

    context "four black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 4
        solutions.size.should == 1
        solutions.should include ["a", "b", "c", "d"]
      end
    end
  end
end