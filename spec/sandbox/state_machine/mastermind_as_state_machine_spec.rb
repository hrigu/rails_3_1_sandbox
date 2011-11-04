require "spec_helper"
require File.expand_path(Rails.root) + '/sandbox/state_machine/mastermind_as_state_machine'

describe Mastermind do

  subject { Mastermind.new }

  it "can" do
    subject.should be_a Mastermind

    secret_code = %w[a b c d]

    guess = %w[b c d e]
    #initial state: :stop
    subject.state_name.should == :start
    subject.secret_code = secret_code
    subject.state_name.should == :wait_for_guess
    subject.secret_code.should == secret_code

    subject.guess = guess
    subject.state_name.should == :wait_for_evaluation
    subject.current_guess.should == guess

    eval = [0, 3]
    subject.evaluation = eval
    subject.state_name.should == :wait_for_guess
    subject.current_evaluation.should == eval

    subject.guess = guess
    subject.evaluation = [4, 0]
    subject.state_name.should == :finished






  end
end