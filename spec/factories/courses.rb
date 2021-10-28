FactoryBot.define do
  factory :course do
    title { Faker::Hobby.activity }
    description { Faker::Lorem.paragraph }
    instructor { Faker::Name.name }
    duration { rand(12) }
    # image { Faker::Name.name }
    image { ActionDispatch::Http::UploadedFile.new("#{Rails.root}/spec/test_images/instructor1.jpeg") }
  end
end
