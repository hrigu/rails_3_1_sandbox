require 'spec_helper'

describe CommentsController do


  before(:each)do
    @post = double "post"#Post.create! valid_post_attributes
    @post.stub(:id) {1}
    Post.stub(:find) do |id|
       @post
    end
    @comment = double "comment" #Comment.create! valid_comment_attributes(post)
    @comment.stub(:id) {2}
    Comment.stub(:find_all_by_post_id) do |id|
       [@comment]
    end
    #the id of the comment
    Comment.stub(:find) do |id|
       @comment
    end
    @new_comment = double "new_comment"
    @new_comment.stub(:save){@new_comment}
    Comment.stub(:new){@new_comment}
  end

  describe "GET index" do
    it "assigns all comments as @comments" do
      get :index, post_id: @post.id
      assigns(:comments).should eq([@comment])
    end
  end

  describe "GET show" do
    it "assigns the requested post_comment as @post_comment" do
      get :show, post_id: @post.id, id: @comment.id
      assigns(:comment).should eq(@comment)
    end
  end

  describe "GET new" do
    it "assigns a new post_comment as @post_comment" do
      get :new, post_id: @post.id
      assigns(:comment).should eq @new_comment
    end
  end

  describe "GET edit" do
    it "assigns the requested post_comment as @post_comment" do
      get :edit, post_id: @post.id, id: @comment.id
      assigns(:comment).should eq(@comment)
    end
  end

end
