FactoryBot.define do
  factory :idea do
    association :user, factory: :user

    sequence(:title) { |n| "#{Faker::ChuckNorris.fact} - #{n}" }
    description { Faker::Lorem.paragraph }
  end
end
