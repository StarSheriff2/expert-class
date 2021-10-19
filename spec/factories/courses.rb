FactoryBot.define do
  factory :course do
    title { Faker::Hobby.activity }
    description { Faker::Lorem.paragraph }
    instructor { Faker::Name.name }
    duration { rand(12) }
    image { Faker::Internet.url }
  end
end
