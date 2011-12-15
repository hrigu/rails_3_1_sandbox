require 'spec_helper'

describe "post/comments/new.html.haml" do
  before(:each) do
    assign(:post_comment, stub_model(Post::Comment,
      :name => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new post_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => post_comments_path, :method => "post" do
      assert_select "input#post_comment_name", :name => "post_comment[name]"
      assert_select "textarea#post_comment_content", :name => "post_comment[content]"
    end
  end
end
