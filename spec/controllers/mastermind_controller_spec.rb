require 'spec_helper'

describe MastermindController do

  describe "GET index" do
    it "renders the page" do
      get :index
      response.should render_template("mastermind/index")
      response.should render_template("layouts/application")
    end
  end

end
