require 'spec_helper'

def create_spec size_of_code = 4, num_of_colors = 6
  GameSpecification.new({master: "Computer", solver: "Computer", size_of_code: size_of_code, num_of_colors: num_of_colors})
end

describe "initialize Game" do
  before :each do
    @spec = create_spec
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
      fails = 0
      200.times do
        @g = Game.new @spec
        until @g.solved
          begin
            @g.put
            if @g.state == Game::WAIT_FOR_NEW_GUESS
              unless @g.solver.solution_disposer.include? @g.master.secret_code
                puts "lost secret_code: #{@g.master.secret_code}"
                puts "last guess: #{@g.board.current_guess}"
                puts @g.solver.solution_disposer.solutions_to_s
                fails+=1
                break
              end
            end
          rescue MastermindError => boom
            puts @g.master.secret_code.inspect
            fails+=1
            break
          end
        end
      end
      fails.should == 0
    end
  end
end