require 'spec_helper'

describe "comments/index.html.haml" do
  before(:each) do
    assign(:comments, [
      stub_model(Post::Comment,
        :name => "Name",
        :content => "MyText"
      ),
      stub_model(Post::Comment,
        :name => "Name",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of post/comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
