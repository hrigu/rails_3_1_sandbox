require 'spec_helper'


describe StatemachineHelper do
  before :each do
    @plane = double "post"
    @plane.stub(:state_events){%w[a b c]}
  end
  it "creates links" do
    links = helper.links
    links.size.should == 3
    p links
    links[0].should be_an_instance_of Hash
    links[0][:name].should == "a"
    links[0][:path].should == "/statemachine?event=a"

  end

end
