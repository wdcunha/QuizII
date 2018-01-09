FactoryBot.define do
  factory :idea do

    sequence(:title) { |n| "#{Faker::ChuckNorris.fact} - #{n}" } 
    # description "My description"
    description { Faker::Lorem.paragraph }

  end
end
