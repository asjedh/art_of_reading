# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    sequence(:username) { |n| "user_#{n}" }
    password "testing123"
    password_confirmation "testing123"
  end
end
