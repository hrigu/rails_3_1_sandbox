require "spec_helper"

describe MastermindController do
  describe "routing" do

    it "routes to #index" do
      get("/mastermind").should route_to("mastermind#index")
    end
    it "routes to #start_game" do
      get("/mastermind/start_game").should route_to("mastermind#start_game")
    end
  end

  describe "path_methods" do
    it "mastermind_path" do
      mastermind_path.should == "/mastermind"
    end
  end

  it "mastermind_start_game_path" do
    mastermind_start_game_path.should == "/mastermind/start_game"
  end

end
