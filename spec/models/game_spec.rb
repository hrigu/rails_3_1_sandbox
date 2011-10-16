require 'spec_helper'

describe Game do
  it "find the stored instance" do
    g1 = Game.new
    g2 = Game.new
    g1.id.class.should == Fixnum
    gfound = Game.find g1.id
    gfound.should be g1
  end
end
