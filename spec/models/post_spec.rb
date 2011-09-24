require 'spec_helper'


describe Post do
  it "works out of the box" do
    post = Post.new
    post.should be_valid
  end
end
