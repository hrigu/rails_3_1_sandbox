require 'spec_helper'

describe "Comments" do
  describe "GET post/1/comments" do
    it "shows all comments of a given post" do
      @post = FactoryGirl.create(:post)
      FactoryGirl.create(:comment, name: "first", post_id: @post.id)
      FactoryGirl.create(:comment, name: "second", post_id: @post.id)

      get post_comments_path(@post)

      @response.status.should be(200)
      @response.body.should include("first")
      @response.body.should include("second")
      puts @response.body
    end
  end
end
