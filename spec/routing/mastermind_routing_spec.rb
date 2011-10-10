require "spec_helper"

describe MastermindController do
  describe "routing" do

    it "routes to #index" do
      get("/mastermind").should route_to("mastermind#index")
    end
  end

  describe "path_methods" do
    it "mastermind_path" do
      mastermind_path.should == "/mastermind"
    end
  end
end
