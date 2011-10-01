# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
      title "firstPost"
      body "It's nice'"
      published false
    end
end