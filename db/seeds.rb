User.destroy_all
City.destroy_all
Course.destroy_all
Reservation.destroy_all

users = User.create!([
  {username: 'arturo_coder', name:'Arturo'},
  {username: 'mih_coder', name:'Mih'},
  {username: 'francisko', name:'Francis'},
  {username: 'brenoxav', name:'Breno'},
])

cities = City.create!([
  {name: 'Ciudad de Mexico, Mexico'},
  {name: 'New York, USA'},
  {name: 'Abuja, Nigeria'},
  {name: 'São Paulo, Brasil'}
])

courses = Course.create!([
  {title: 'Urban Photography', description: 'Learn to take photos of urban landscapes.', duration: 4, instructor: 'Maria'},
  {title: 'Modern Gardening', description: 'Learn to plant plants.', duration: 8, instructor: 'Mohammed'},
  {title: 'Play the Piano', description: 'Learn to play the piano.', duration: 12, instructor: 'Yin'},
  {title: 'Master Chef', description: 'Learn to cook delicious dishes.', duration: 12, instructor: 'Paola'}
])

reservations = Reservation.create!([
  {date: Date.new(), user_id: users[0].id, course_id: courses[0].id, city_id: cities[0].id},
  {date: Date.new(), user_id: users[1].id, course_id: courses[1].id, city_id: cities[1].id},
  {date: Date.new(), user_id: users[2].id, course_id: courses[2].id, city_id: cities[2].id},
  {date: Date.new(), user_id: users[3].id, course_id: courses[3].id, city_id: cities[3].id}
])
