require 'spec_helper'

describe AjaxController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "post 'add_comment'" do
    it "returns http success" do
      post :add_comment, :comment => {message: "hi"}, :format => :js
      response.should be_success
      response.content_type.should == "text/javascript"
      assigns(:message).should eq("hi")
    end
  end

  describe "post 'clear'" do
    it "returns http success" do
      get :clear, :format => :js
      response.should be_success
      response.content_type.should == "text/javascript"
    end
  end

end
