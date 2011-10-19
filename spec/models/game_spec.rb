require 'spec_helper'

describe "Storing Games" do
  context "when two instances are stored" do
    before(:each) do
      @g1 = Game.new
      @g2 = Game.new
    end

    it "you can find the stored instance by the id" do
      gfound = Game.find @g1.id
      gfound.should be @g1
    end

    it "the ids are different" do
      @g1.id.should_not == @g2.id
    end
  end
end

describe "initialize Game" do
  context "Human vs Computer" do
    it "the human_vs_computer strategy is used" do
      @g = Game.new
      @g.properties = {master: "Mensch", solver: "Computer", size_of_code: "4", num_of_colors: "6"}
      @g.start
      until @g.solved
        @g.guess
      end

    end
  end
end
