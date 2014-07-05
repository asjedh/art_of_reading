# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    sequence(:title) { |n| "Awesome Book #{n}" }
    sequence(:description) { |n| "Cool Book #{n}" }

    book
  end
end
