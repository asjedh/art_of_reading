# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    sequence(:user_name) { |n| "user_name" }
    password "testing123"
    password_confirmation "testing123"
  end
end
