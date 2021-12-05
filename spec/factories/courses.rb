FactoryBot.define do
  factory :course do
    title { Faker::Hobby.activity }
    description { Faker::Lorem.paragraph }
    instructor { Faker::Name.name }
    duration { rand(12) }
    # let(:path_to_file) { Rails.root.join 'spec/fixtures/file.csv' }
    image { Rack::Test::UploadedFile.new Rails.root.join('spec', 'test_images', 'instructor1.jpeg'), 'image/jpeg' }
    # image { Faker::Internet.url(host: 'faker', path: '/fake_test_path', scheme: 'https') }
    # image { File.open(Dir.glob(File.join(Rails.root, 'spec/test_images', '*')).sample) }
    # image { Rails.root.join('spec', 'test_images', 'instructor1.jpeg') }
    # course_image_url { ActionDispatch::Http::UploadedFile.new("#{Rails.root}/spec/test_images/instructor1.jpeg") }
  end
end
