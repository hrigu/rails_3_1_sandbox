require 'spec_helper'

describe "comments/show.html.haml" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "myPost",
      :body => "hihi"
    ))
    @comment = assign(:comment, stub_model(Comment,
      :name => "Name",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
