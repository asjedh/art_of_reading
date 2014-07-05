# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:name) { |n| "Awesome chapter #{n}" }
    sequence(:summary) { |n| "This was a great book! You should read it. #{n}" }
    sequence(:tldr) { |n| "Good #{n}" }
    sequence(:key_concepts) { |n| "Photosynthesis - how plants convert energy #{n}" }
    sequence(:reflection) { |n| "This changed my life #{n}" }

    book
  end
end
