FactoryBot.define do
  # factory :course do
  #   title { Faker::Hobby.activity }
  #   description { Faker::Lorem.paragraph }
  #   instructor { Faker::Name.name }
  #   duration { rand(12) }
  #   image { Rack::Test::UploadedFile.new('spec/test_images/instructor1.jpeg', 'image/jpeg') }
  # end
  factory :reservation do
    date { Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now) }
    user_id { rand(12) }
    course_id { rand(12) }
    city_id { rand(12) }
  end
end

# FactoryGirl.define do
#   factory :completed_set do
#     user
#     # ... left out for brevity
#   end
# end
