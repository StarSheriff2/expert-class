FactoryBot.define do
  factory :course do
    title { Faker::Hobby.activity }
    description { Faker::Lorem.paragraph }
    instructor { Faker::Name.name }
    duration { rand(12) }
    image { Rack::Test::UploadedFile.new('spec/test_images/instructor1.jpeg', 'image/jpeg') }
  end
end
