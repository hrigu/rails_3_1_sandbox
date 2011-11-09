require "rspec"
require 'state_machine'

module IdleState
  def start
    puts "start"
    super
  end
end

module RunningState
  def stop
    puts "stop"
    super
  end
end


class StateAsClasses
  state_machine initial: :idle do
    event :start do
      transition :idle => :running
    end
    event :stop do
      transition :running => :idle
    end
    state :idle do
      include IdleState
    end
    state :running do
      include RunningState
    end
  end


end


describe StateAsClasses do
  subject { StateAsClasses.new }

  it "has idle as initial state" do
    subject.state_name.should == :idle
    subject.start
    subject.state_name.should == :running
    subject.stop
    subject.state_name.should == :idle
  end
end