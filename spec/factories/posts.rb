# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
      title "firstPost"
      body "rails is great"
      published false
    end
end