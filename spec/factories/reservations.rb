FactoryBot.define do
  factory :reservation do
    name { Faker::Name.name }
  end
end
