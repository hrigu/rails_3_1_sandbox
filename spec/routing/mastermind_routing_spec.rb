require "spec_helper"

describe MastermindController do
  describe "routing" do

    it "routes to #index" do
      get("/mastermind").should route_to("mastermind#index")
    end
    it "routes to #new_game" do
      get("/mastermind/new_game").should route_to("mastermind#new_game")
    end
  end

  describe "path_methods" do
    it "mastermind_path" do
      mastermind_path.should == "/mastermind"
    end
  end

  it "mastermind_new_game_path" do
    mastermind_new_game_path.should == "/mastermind/new_game"
  end

end
