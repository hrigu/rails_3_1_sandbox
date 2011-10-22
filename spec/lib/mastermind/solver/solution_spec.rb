require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/solution'

describe Solution do

  describe "initializing with an array" do

    it "should have a code that is equals but not the same as the initializing array" do
      a = %w[a b c d]
      s = Solution.new a
      s.code.should == a
      s.code.should_not be a  #identical
    end
  end

  describe "initializing with a Solution" do

    it "should have a code that match the code of its parent solution" do
      a = %w[a b c d]
      s1 = Solution.new a
      s2 = Solution.new s1

      s2.code.should == a
      s2.code.should_not be a  #identical

    end
  end

  describe "initializing with a Solution with not_possible_colors" do

    it "should have the same not_possible_colors" do
      a = ["a", nil, "c", nil]
      guess = ["a" "c", "d", "d"]
      s1 = Solution.new a
      s1.mark_not_possible_solutions_after_black guess

      s2 = Solution.new s1
      s2.not_possible_colors == s1.not_possible_colors
      s2.not_possible_colors.should_not be s1.not_possible_colors  #identical
      s2.not_possible_colors[1].should_not be s1.not_possible_colors[1]
    end
  end

  describe "mark not possible colors after black" do
    it "should show this" do
      s = Solution.new ["a", nil]
      s.mark_not_possible_solutions_after_black ["a", "b"]
      s.not_possible_colors[1].should include "b"
    end
  end

  describe "add_not_used_colors_to_the_not_possible_colors" do
    it "guess has two different colors" do
      s = Solution.new ["a", nil]
      s.add_not_used_colors_to_the_not_possible_colors %w[a b]
      s.not_possible_colors[0].should be_nil
      s.not_possible_colors[1].to_a.should =~ %w[b]
    end

    it "guess has two different colors" do
      s = Solution.new [nil, "b", nil]
      s.add_not_used_colors_to_the_not_possible_colors %w[a b b]  #one black
      s.not_possible_colors[0].should correlate %w[a b]
      s.not_possible_colors[1].should be_nil
      s.not_possible_colors[2].should correlate %w[a b]
    end
    it "hallo" do
      s = Solution.new ["b", "c", "d", nil]
      s.add_not_used_colors_to_the_not_possible_colors %w[a b c d]  #four white
      s.not_possible_colors[0].should be_nil
      s.not_possible_colors[1].should be_nil
      s.not_possible_colors[2].should be_nil
      s.not_possible_colors[3].should correlate %w[a]
    end
  end


end