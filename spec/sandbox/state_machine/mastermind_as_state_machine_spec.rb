require "spec_helper"
require File.expand_path(Rails.root) + '/sandbox/state_machine/mastermind_as_state_machine'

describe MastermindAsStateMachine do

  subject { MastermindAsStateMachine.new }
  let("secret_code") { %w[a b c d] }
  let ("guess"){%w[b c d e]}
  it "can follow the happy path" do
    subject.should be_a MastermindAsStateMachine
    #initial state: :stop
    subject.state_name.should == :start
    subject.secret_code = secret_code
    subject.state_name.should == :wait_for_guess
    subject.secret_code.should == secret_code

    subject.guess = guess
    subject.state_name.should == :wait_for_evaluation
    subject.current_guess.should == guess
    subject.secret_code.should == secret_code

    eval = [0, 3]
    subject.evaluation = eval
    subject.state_name.should == :wait_for_guess
    subject.current_evaluation.should == eval

    subject.guess = guess
    subject.evaluation = [4, 0]
    subject.state_name.should == :finished


#    file = File.expand_path(Rails.root) + '/sandbox/state_machine/mastermind_as_state_machine'
#    StateMachine::Machine.draw("MastermindAsStateMachine", {file: file})
  end

  it "can be cancelled" do
    subject.state_name.should == :start
    subject.secret_code = secret_code
    subject.state_name.should == :wait_for_guess
    subject.cancel
    subject.state_name.should == :start

  end
end