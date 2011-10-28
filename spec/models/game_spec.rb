require 'spec_helper'

def create_spec master = "Computer", solver = "Computer", size_of_code = 4, num_of_colors = 6
  @spec = GameSpecification.new
  @spec.choose = {master: master, solver: solver, size_of_code: size_of_code, num_of_colors: num_of_colors}

end
describe "initialize Game" do
  before :each do
    create_spec
  end
  context "Computer vs Computer" do
    it "can be initialized" do
      @g = Game.new @spec
      @g.board.should be_instance_of Board
      @g.solver.should be_instance_of ComputerSolver
      @g.master.should be_instance_of ComputerMaster
      @g.master.secret_code.size.should == @spec.size_of_code
      @g.game_spec.master.should == @spec.master
    end
    it "can play a game" do
      begin
        @g = Game.new @spec
      rescue => details
        details.should
      end
      @g.start
      until @g.solved
        @g.guess
        puts "."
      end
    end
  end
  context "Mensch vs Computer" do
    it "is not implemented yet" do
      create_spec("Mensch", "Computer")
        @g = Game.new @spec
      #@g.start
      #until @g.solved
      #  @g.guess
      #end
    end
  end
  context "Mensch vs Mensch" do
    create_spec("Mensch", "Mensch")
    it "makes no sence- > throws an error" do
      begin
        @g = Game.new @spec
      rescue => details
        details.should be_a RuntimeError
      end
    end
  end
end
