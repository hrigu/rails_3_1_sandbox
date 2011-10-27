require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/master/computer_master'

describe ComputerMaster do
  before :each do
    @possible_colors = %w[a b c]
    @num_of_elements = 4
    @board = double "board"
    @board.stub :num_of_elements do
      @num_of_elements
    end

    @board.stub :possible_colors do
      @possible_colors
    end
    @master = ComputerMaster.new @board

  end
  it "can build a hidden code" do
    secret_code = @master.build_secret_code
    secret_code.size.should == @num_of_elements
    secret_code.each do |e|
      @possible_colors.should include e
    end
  end

  it "can evaluate" do
    secret_code = %w[a a b b]
    @master.secret_code = secret_code
    result = @master.evaluate %w[a b c c]
    result.should == [1, 1]
  end
end