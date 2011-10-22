require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/black_solver'
require File.expand_path(Rails.root) + '/lib/mastermind/solver/solution'

describe BlackSolver do
  context "two positions, guess = [a b]" do
    context "zero black" do
      it "should find one solution, [nil nil]" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b], 0
        solutions.size.should == 1
        solution = solutions[0]
        solution.code.should == [nil, nil]

        solution.not_possible_colors[0].should == %w[a].to_set
        solution.not_possible_colors[1].should == %w[b].to_set
      end
    end
    context "one black" do
      it "should find two solutions, [a nil] and [nil b]" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b], 1
        solutions.size.should == 2
        solutions.should contain ["a", nil]
        solutions.should contain [nil, "b"]
      end
    end
    context "two black" do
      it "should find one solution, [a b]" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b], 2
        solutions.size.should == 1
        solutions.should contain ["a", "b"]
      end
    end
  end
  context "four positions, guess = [a b c d]" do
    context "one black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 1

        solutions.size.should == 4
        solutions.should contain ["a", nil, nil, nil]
        solutions.should contain [nil, "b", nil, nil]
        solutions.should contain [nil, nil, "c", nil]
        solutions.should contain [nil, nil, nil, "d"]
      end
    end
    context "two black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 2
        solutions.size.should == 6
        solutions.should contain ["a", "b", nil, nil]
        solutions.should contain [nil, "b", "c", nil]
        solutions.should contain [nil, nil, "c", "d"]
        solutions.should contain ["a", nil, nil, "d"]

        #not
        solutions.should_not contain ["a", "b", nil, "d"]
        solutions.should_not contain ["a", nil, "b", nil]
      end
    end
    context "three black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 3
        solutions.size.should == 4

        solutions.should contain ["a", "b", "c", nil]
        solutions.should contain ["a", nil, "c", "d"]


      end
    end

    context "four black" do
      it "should get four solutions" do
        black_solver = BlackSolver.new
        solutions = black_solver.find_solutions %w[a b c d], 4
        solutions.size.should == 1
        solutions.should contain ["a", "b", "c", "d"]
      end
    end
  end
end