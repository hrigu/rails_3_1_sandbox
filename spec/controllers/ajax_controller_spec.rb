require 'spec_helper'

describe AjaxController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  #TODO It should be a javascript call.
  describe "put 'invoke'" do
    it "returns http success" do
      put 'invoke', {put: {message: "hi"}}
      response.should be_success
    end
  end

end
