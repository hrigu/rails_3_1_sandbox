# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
      post_id 1
      name "first_comment"
      content "first_content"
    end
end