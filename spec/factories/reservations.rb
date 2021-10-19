FactoryBot.define do
  factory :reservation do
    association :user, :course, :city
    date { '20-10-2021' }
    user_id { rand(100) } 
    course_id { rand(100) } 
    city_id { rand(100) }
  end
end
