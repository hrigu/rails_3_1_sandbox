Given /^a internet connection$/ do
  #do nothing
end


When /^I enter the home$/ do
  visit "/"
end

Then /^I see the home$/ do
  puts page.class.name
  page.should have_content("Home")

end