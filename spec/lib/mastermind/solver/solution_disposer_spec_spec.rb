require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/solution_disposer'

describe SolutionDisposer do
  context "Initialize" do
    context "with one color" do
      it "has one solution" do
        @solution_disposer = SolutionDisposer.new(4, %w[a])
        @solution_disposer.possible_solutions.size.should == 1
      end
    end
    context "with two color and length 2" do
      it "has 4 solution" do
        @solution_disposer = SolutionDisposer.new(2, %w[a b])
        @solution_disposer.possible_solutions.size.should == 4
      end
    end
    context "with two color and length 3" do
      it "has 8 solution" do
        @solution_disposer = SolutionDisposer.new(3, %w[a b])
        @solution_disposer.possible_solutions.size.should == 8
      end
    end
  end

  context "Add elements" do
    before(:each) do
      @solution_disposer = SolutionDisposer.new(4, %w[a b c d])
    end

    context "solution_disposer is empty" do
      it "should accept a correct element" do
        @solution_disposer.size_of_current_possible_solutions.should == 0
        @solution_disposer.add %w[a b c d]
        @solution_disposer.size_of_current_possible_solutions.should == 1
      end

      it "should not accept a bad element" do
        @solution_disposer.size_of_current_possible_solutions.should == 0
        @solution_disposer.add "[a b c d]"
        @solution_disposer.size_of_current_possible_solutions.should == 0
      end
      it "should not accept an element with unkwnown color" do
        @solution_disposer.size_of_current_possible_solutions.should == 0
        @solution_disposer.add %w[a b c e]
        @solution_disposer.size_of_current_possible_solutions.should == 0
      end

      it "should only accept a solution once" do
        @solution_disposer.size_of_current_possible_solutions.should == 0
        @solution_disposer.add %w[a b c d]
        @solution_disposer.size_of_current_possible_solutions.should == 1
        @solution_disposer.add %w[a b c d]
        @solution_disposer.size_of_current_possible_solutions.should == 1
      end
    end
  end


end