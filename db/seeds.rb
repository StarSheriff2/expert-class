City.destroy_all
User.destroy_all
Course.destroy_all

City.create!([{name: 'London, UK'}, {name: 'Paris, France'}, {name: 'Madrid, Spain'}, {name: 'New York, USA'}, {name: 'Abuja, Nigeria'}, {name: 'São Paulo, Brasil'}, {name: 'Ciudad de Mexico, Mexico'}])
User.create!([{username: 'maria2021', name:'Maria'}, {username: 'arturo_coder', name:'Arturo'}, {username: 'mih_coder', name:'Mih'}])
Course.create!([{title: 'Urban Photography', description: 'Learn to take photos of urban landscapes.', duration: 4, instructor: 'Maria', image: ''}])
