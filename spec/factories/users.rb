FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Lorem.characters(number: 10) }
  end
end
