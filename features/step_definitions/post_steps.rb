Given /^two posts$/ do
  Factory.create(:post, title: "firstPost")
  Factory.create(:post, title: "secondPost")

  Post.all.each do   |p|
    puts p.title
  end
end

Then /^I see both posts$/ do
  Post.all.each do   |p|
    page.should have_content (p.title)
  end
end