FactoryBot.define do
  factory :reservation do
    date { '20-10-2021' }
    user
    course
    city
  end
end
