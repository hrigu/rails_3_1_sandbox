require 'spec_helper'

describe CommentsController do

  def valid_post_attributes
    {}
  end

  def valid_comment_attributes post
    {name: "the_name", content: "the_content", post_id: post.id}
  end

  before(:each)do
    @post = Post.create! valid_post_attributes
  end

  describe "POST create" do
    describe "with valid params" do
      it "redirects to the parent post" do
        post :create, post_id: @post.id, comment: valid_comment_attributes(@post)
        response.should redirect_to post_comments_path(@post)
      end

      it "assigns a newly created comment as @comment" do
        post :create, post_id: @post.id, comment: valid_comment_attributes(@post)
        assigns(:post).should be_a(Post)
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, post_id: @post.id, comment: {}
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, post_id: @post.id, post_comment: {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested comment" do
        comment = Comment.create! valid_comment_attributes(@post)
        # Assuming there are no other post_comments in the database, this
        # specifies that the Comment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Comment.any_instance.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
        put :update, post_id: @post.id, id: comment.id, comment: {'these' => 'params'}
      end

      it "assigns the requested comment as @comment" do
        comment = Comment.create! valid_comment_attributes(@post)
        put :update, post_id: @post.id, id: comment.id, comment: valid_comment_attributes(@post)
        assigns(:comment).should eq(comment)
      end

      it "redirects to the post_comment" do
        comment = Comment.create! valid_comment_attributes(@post)
        put :update, post_id: @post.id, id: comment.id, comment: valid_comment_attributes(@post)
        response.should redirect_to [@post, comment]
      end
    end
    describe "with invalid params" do
      it "assigns the comment as @comment" do
        comment = Comment.create! valid_comment_attributes(@post)
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        put :update, post_id: @post.id, id: comment.id, comment: {}
        assigns(:comment).should eq(comment)
      end

      it "re-renders the 'edit' template" do
        comment = Comment.create! valid_comment_attributes(@post)
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        put :update, post_id: @post.id, id: comment.id, comment: {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_comment_attributes(@post)
      expect {
        delete :destroy, post_id: @post.id, id: comment.id
      }.to change(Comment, :count).by(-1)
      response.should redirect_to(post_comments_url)
     end
  end
end
