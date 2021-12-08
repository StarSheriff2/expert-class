FactoryBot.define do
  factory :reservation do
    date { Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now) }
    user
    city
    course
  end
end
