require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "shows all posts" do
      @post = FactoryGirl.create(:post)

      #capybara
      #visit posts_path
      save_and_open_page
      page.should have_content "rails is great"
     #visit posts_path
     # @response.status.should be(200)
     # @response.body.should include "rails is great"

    end
  end

  describe "POST /post" do
    it "creates a post" do
      post_via_redirect posts_path, post: FactoryGirl.attributes_for(:post, published: true)
      @response.body.should include "Post was successfully created."
      @response.body.should include "rails is great"
      @response.body.should include "true"
      puts @response.body
    end
  end
end
