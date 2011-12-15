require 'spec_helper'

describe "comments/new.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "myPost",
      :body => "hihi"
    ))
    assign(:comment, stub_model(Comment,
      :name => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new post_comment form" do
    render
    puts @rendered
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => post_comments_path(@post), :method => "post" do
      assert_select "input#comment_name", :name => "comment[name]"
      assert_select "textarea#comment_content", :name => "comment[content]"
    end
  end
end
