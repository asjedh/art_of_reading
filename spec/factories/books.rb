# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Awesome Book #{n}" }
    publication_year 2000

    user
  end
end
