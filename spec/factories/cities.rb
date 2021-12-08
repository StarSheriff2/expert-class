FactoryBot.define do
  factory :city do
    name { Faker::Nation.capital_city }
  end
end
