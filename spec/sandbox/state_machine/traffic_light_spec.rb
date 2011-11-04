require "spec_helper"
require File.expand_path(Rails.root) + '/sandbox/state_machine/traffic_light'

describe TrafficLight do

  subject { TrafficLight.new }

  it "should cycle to all states" do
    subject.should be_a TrafficLight
    p subject.state_transitions

    #initial state: :stop
    subject.state_name.should == :stop
    subject.color.should == "red"
    subject.state_events.should == [:cycle]

    subject.cycle
    subject.state_name.should == :proceed
    subject.color.should == "green"
    subject.state_events.should == [:cycle]

    subject.cycle
    subject.state_name.should == :caution
    subject.color.should == "orange"
    subject.state_events.should == [:cycle]

    subject.cycle
    subject.state_name.should == :stop
    subject.color.should == "red"
    subject.state_events.should == [:cycle]


  end
end