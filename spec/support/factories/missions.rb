require 'factory_bot'

FactoryBot.define do
  factory :mission do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
