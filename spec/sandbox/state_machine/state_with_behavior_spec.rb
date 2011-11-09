  require "rspec"
  require 'state_machine'



  class StateWithBehavior
    state_machine initial: :idle do
      event :go do
        transition :idle => :running
        transition :running => :idle
      end
      state :idle do
        def go
          puts "start"
          super
        end
      end
      state :running do
        def go
          puts "stop"
          super
        end
      end
    end
  end


  describe StateWithBehavior do
    subject { StateWithBehavior.new }
    it "has idle as initial state" do
      subject.state_name.should == :idle
      subject.go
      subject.state_name.should == :running
      subject.go
      subject.state_name.should == :idle
    end
  end