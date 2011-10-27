require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/human_solver'

describe HumanSolver do
  it "can write a guess" do
    solver = HumanSolver.new %w[a b c d], 4
    solver.current_guess = %w[a b b a]
    guess = solver.make_guess
    guess.should == %w[a b b a]
  end
end


