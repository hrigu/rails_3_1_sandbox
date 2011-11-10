require 'spec_helper'

describe StatemachineController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      assigns(:plane).state.should eq("parked")
    end
  end

  describe "GET 'index' with 'start'" do
    before :each do
      get 'index' #to initialize a new game
    end
    it "turns the plane to rolling" do
      get 'index', :event => "start"
      response.should be_success
      assigns(:plane).state.should eq("rolling")
    end
  end

end
