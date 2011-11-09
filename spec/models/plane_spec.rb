require 'spec_helper'

describe Plane do

  subject {Plane.new}
  it "can move through its states" do
    subject.state_name.should == :parked
    subject.start
    subject.state_name.should == :rolling
    subject.stop
    subject.state_name.should == :parked
    subject.start
    subject.accelerate
    subject.state_name.should == :flying
    subject.sinking
    subject.state_name.should == :rolling
    subject.stop
    subject.state_name.should == :parked



=begin
subject.state_name.should == :rolling
subject.stop
subject.state_name.should == :parked
subject.start
subject.force
subject.state_name.should == :flying
subject.stop
subject.state_name.should == :parked

=end
  end
end