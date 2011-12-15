require 'spec_helper'

describe "comments/edit.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "myPost",
      :body => "hihi"
    ))
    @comment = assign(:comment, stub_model(Post::Comment,
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form", :action => post_comments_path(@post, @comment), :method => "post" do
      assert_select "input#comment_name", :name => "comment[name]"
      assert_select "textarea#comment_content", :name => "comment[content]"
    end
  end
end
