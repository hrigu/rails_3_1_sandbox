require 'spec_helper'

describe "A comment" do
  before :each do
    Post.all.size.should == 0
    Comment.all.size.should == 0
    @post = FactoryGirl.create(:post)
    @comment = FactoryGirl.create(:comment, post_id: @post.id)
    Post.all.size.should == 1
    Comment.all.size.should == 1

  end

  it "belongs to a post" do
    @comment.post_id.should_not be_nil
    @comment.post.should == @post

    @post.comments.size.should == 1
    @post.comments[0].should == @comment
 end

  it "will be killed if the related post is destroyed" do

    @post.destroy
    Post.all.size.should == 0
    Comment.all.size.should == 0

  end
end
