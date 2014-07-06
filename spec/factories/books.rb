# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Awesome Book #{n}" }
    sequence(:description) { |n| "Cool Book #{n}" }

    user
  end
end
