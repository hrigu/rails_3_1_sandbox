require 'spec_helper'

describe "Mensch vs Computer" do
  it "works" do
    map = {:master => "Computer", :solver => "Computer", :size_of_code => "2", :num_of_colors => "6"}
    game_spec1 = GameSpecification.new
    game_spec1.choose = map

    @g = Game.new game_spec1
    secret_code = [game_spec1.colors[0], game_spec1.colors[1]]

    @g.start
  #  @g.secret_code = secret_code
    pending "after implementing"

#    @g.mastermind.code.should == code
  end
end
