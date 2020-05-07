require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:full_name) { |n| "Naruto#{n}" }
    sequence(:email) { |n| "naruto#{n}@email.com" }
    role { 0 }
    profile_image { "#{Rails.root}/spec/support/images/naruto.png" }
    password { "banana" }
    password_confirmation { "banana" }

    trait :admin do
      sequence(:full_name) { |n| "Hokage#{n}" }
      role { 1 }
    end
  end
end
