require 'spec_helper'

def create_spec size_of_code = 4, num_of_colors = 6
  @spec = GameSpecification.new( {master: "Computer", solver: "Computer", size_of_code: size_of_code, num_of_colors: num_of_colors} )
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
        fail

      end
      until @g.solved
        @g.put
        puts "."
      end
    end
  end
end