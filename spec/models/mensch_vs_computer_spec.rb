require 'spec_helper'

describe "Mensch vs Computer" do
  it "works" do
    game_spec = GameSpecification.new ({:master => "Mensch", :solver => "Computer", :size_of_code => "2", :num_of_colors => "2"})

    @g = Game.new game_spec
    secret_code = [game_spec.colors[0], game_spec.colors[1]]

  #  @g.secret_code = secret_code
#    pending "after implementing of HumanComputerStrategy"

#    @g.mastermind.code.should == code
  end
end
