require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/mastermind'

describe "Evaluator can evaluate guesses" do

  context "The code has four different colors" do
    before(:all) do
      @code = :r, :b, :g, :y
      @evaluator = Evaluator.new
    end

    context "and the guess is exactly the same code" do
      before(:each) do
        @result = @evaluator.evaluate(@code, @code)
      end

      it "the result should has four blacks and zero white" do
        @result[0].should == 4
        @result[1].should == 0
      end
    end

    context "and the guess has two members that has the correct color and are on the right place" do
      before(:each) do
        guess = :r, :b, :p, :l
        @result = @evaluator.evaluate(@code, guess)
      end

      it "the result should has two blacks and zero white" do
        @result[0].should == 2
        @result[1].should == 0
      end
    end

    context "and the guess has one member with the correct color but on the wrong place" do
      before(:each) do
        guess = :p, :r, :o, :l
        @result = @evaluator.evaluate( @code, guess )
      end

      it "the result should has zero blacks and one white" do
        @result[0].should == 0
        @result[1].should == 1
      end
    end

    context "and the guess has two members with the correct color: One on the correct place" do
      before(:each) do
        guess = :r, :r, :o, :l
        @result = @evaluator.evaluate(@code, guess)
      end

      it "the result should have zero blacks and one white" do
        @result[0].should == 1
        @result[1].should == 0
      end
    end
  end

  context "The code has two member with the same color" do
    before(:all) do
      @code = :r, :b, :b, :y
      @evaluator = Evaluator.new
    end

    context "and the guess has only one member with this color, but on the wrong place" do
      before(:each) do
        guess = :g, :g, :o, :b
        @result = @evaluator.evaluate(@code, guess)
      end

      it "the result should have zero blacks and one white" do
        @result[0].should == 0
        @result[1].should == 1
      end
    end

    context "and the guess has only two member with this color, but on the wrong place" do
      before(:each) do
        guess = :b, :g, :o, :b
        @result = @evaluator.evaluate(@code, guess)
      end

      it "the result should have zero blacks and one white" do
        @result[0].should == 0
        @result[1].should == 2
      end
    end


  end


end