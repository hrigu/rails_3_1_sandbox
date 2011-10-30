require 'spec_helper'

describe "Storing Games" do
  context "when two instances are stored" do
    before(:each) do
      map = {:master => "Computer", :solver => "Computer", :size_of_code => "4", :num_of_colors => "6"}
      game_spec1 = GameSpecification.new   map
      game_spec2 = GameSpecification.new   map

      @g1 = Game.new game_spec1
      @g2 = Game.new game_spec2
    end

    it "you can find the stored instance by the id" do
      gfound = GameHolder.find @g1.id
      gfound.should be @g1
    end

    it "the ids are different" do
      @g1.id.should_not == @g2.id
    end
  end
end
