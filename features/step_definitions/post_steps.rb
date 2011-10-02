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

Given /^a post with title "([^"]*)"$/ do |title|
  Factory.create(:post, title: title)
end

Then /^I see the details of the "([^"]*)" post$/ do |title|
  post = Post.find_by_title title
  page.should have_content(post.title)
  page.should have_content(post.body)
end