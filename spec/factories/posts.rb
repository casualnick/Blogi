require 'faker'

FactoryBot.define do
  factory :post do
    title { "This is vert example title" }
    content { Faker::Lorem.paragraphs }
    user_id { nil }
  end
end
