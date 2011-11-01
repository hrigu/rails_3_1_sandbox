require 'spec_helper'



describe "Mensch vs Computer" do
  def create_spec size_of_code = 4, num_of_colors = 6
    GameSpecification.new({master: "Mensch", solver: "Computer", size_of_code: size_of_code, num_of_colors: num_of_colors})
  end
  before :each do ||
    @spec = create_spec
  end
  it "works" do
    @g = Game.new @spec
    @spec.master.should == "Mensch"
    @g.type.should == Game::MENSCH_COMPUTER
    secret_code = [@spec.colors[0], @spec.colors[1]]
    @g.put secret_code
    p @g.possible_solutions
    @g.put %w[black]
    p @g.possible_solutions
    @g.put %w[black black white white]
    p @g.possible_solutions
    @g.put %w[black black black black]
  end
end
