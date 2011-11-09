require 'spec_helper'

describe StatemachineController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'start'" do
    it "returns http success" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'stop'" do
    it "returns http success" do
      get 'stop'
      response.should be_success
    end
  end

  describe "GET 'fly'" do
    it "returns http success" do
      get 'fly'
      response.should be_success
    end
  end

end
