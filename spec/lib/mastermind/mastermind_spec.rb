require File.expand_path(Rails.root) + '/lib/mastermind/mastermind'
require "spec_helper"



describe Mastermind do

  before :each       do
    @colors = %[a b c d e f]
    num_of_elements = 4
    @mastermind = Mastermind.new @colors, num_of_elements

  end

  it "initializes properly" do
    @mastermind.should be_an_instance_of Mastermind
  end

  it "play one round" do
    hidden_code = %w[a a c e]
    guess = %w[a a c e]
    master = double "master"
    master.stub(:build_secret_code) do
      hidden_code
    end
    master.stub(:solved) do
      true
    end
    master.stub(:evaluate) do |g|
      g.should == guess
      [4, 0]
    end

    solver = double "solver"
    solver.stub :make_guess do
      guess
    end

    @mastermind.master = master
    @mastermind.solver = solver


    @mastermind.play

    board = @mastermind.board
    board.guesses.size.should == 1
    board.current_guess.code.should == guess
    board.current_guess.num_of_blacks.should == 4
    board.current_guess.num_of_whites.should == 0

    #p board.all_guesses_to_s

  end
end