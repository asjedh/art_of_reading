FactoryGirl.define do
  factory :author do
    sequence(:name) { |n| "Cool Dude" }
  end
end
