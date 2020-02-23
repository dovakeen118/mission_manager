require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:full_name) { |n| "Naruto#{n}" }
    sequence(:email) { |n| "naruto#{n}@email.com" }
    password { "banana" }
    password_confirmation { "banana" }
  end
end
