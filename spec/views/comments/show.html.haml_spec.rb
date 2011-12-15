require 'spec_helper'

describe "post/1/comments/show.html.haml" do
  before(:each) do
    @post_comment = assign(:post_comment, stub_model(Post::Comment,
      :name => "Name",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
