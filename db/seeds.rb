require 'cloudinary'

if Cloudinary.config.api_key.blank?
  require './config/cloudinary'
end

User.destroy_all
City.destroy_all
Course.destroy_all
Reservation.destroy_all
image = Rack::Test::UploadedFile.new('spec/test_images/instructor1.jpeg', 'image/jpeg')

generate_date = -> { Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now) }

users = User.create!([
                       { username: 'mih_coder', name: 'Mih' },
                       { username: 'francisko', name: 'Francis' },
                       { username: 'brenoxav', name: 'Breno' },
                       { username: 'arturo_coder', name: 'Arturo' }
                     ])

cities = City.create!([
                        { name: 'Ciudad de Mexico, Mexico' },
                        { name: 'New York, USA' },
                        { name: 'Abuja, Nigeria' },
                        { name: 'São Paulo, Brasil' }
                      ])

courses = Course.create!([
                           {
                             title: 'Urban Photography',
                             description: 'Learn to take photos of urban landscapes.',
                             duration: 4,
                             instructor: 'Maria Segovia',
                             course_image_url: Cloudinary::Utils.cloudinary_url("e9lohjn28q0e63dqos5fa2ijtwut.jpg"),
                             image: image
                           },
                           {
                             title: 'Designing Small Gardens',
                             description: 'Award winning garden designer Annie Guilfoyle teaches you how to
                             design small and urban gardens. You\'ll be designing your own garden
                             and outside space as Annie takes you through the garden design
                             process step-by-step.',
                             duration: 8,
                             instructor: 'Mohammed Masso',
                             course_image_url: Cloudinary::Utils.cloudinary_url("ts01hqjp6rxtij8u7y4lhac0yqmx.jpg"),
                             image: image
                           },
                           {
                             title: 'Beginner Piano Lessons',
                             description: 'Learn the piano with the specialist Erik Deutsch!
                   Discover a full progressive method for piano beginners.
                   Get all the main notions and techniques to begin!',
                             duration: 12,
                             instructor: 'Yin Chang',
                             course_image_url: Cloudinary::Utils.cloudinary_url("piano-teacher_dtri8d.jpg"),
                             image: image
                           },
                           {
                             title: 'Recipes for Beginners',
                             description: 'We’re going to be cooking from the heart and soul! In this fun,
                   upbeat three day cooking course, we will make 4 beginner-friendly,
                   delicious dishes.',
                             duration: 3,
                             instructor: 'Paola Seinfeld',
                             course_image_url: Cloudinary::Utils.cloudinary_url("02d849x8aaywxs4584zt80he83w1.jpg"),
                             image: image
                           }
                         ])

Reservation.create!([
                      { date: generate_date.call, user_id: users[3].id, course_id: courses[0].id,
                        city_id: cities[0].id },
                      { date: generate_date.call, user_id: users[3].id, course_id: courses[1].id,
                        city_id: cities[1].id },
                      { date: generate_date.call, user_id: users[3].id, course_id: courses[2].id,
                        city_id: cities[2].id }
                    ])
