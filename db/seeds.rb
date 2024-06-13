# Clear existing data
EventInstrument.destroy_all
Skill.destroy_all
Event.destroy_all
Instrument.destroy_all
User.destroy_all

PASSWORD = "Coucou!123"

# Create users
user1 = User.create!(
  email: 'teacher@example.com',
  password: PASSWORD,
  first_name: 'John',
  last_name: 'Doe',
  role: 'teacher',
  is_subscriber: true,
  subscription_end_date: DateTime.now + 1.year
)

user2 = User.create!(
  email: 'admin@example.com',
  password: PASSWORD,
  first_name: 'Jane',
  last_name: 'Smith',
  role: 'admin',
  is_subscriber: false
)

user3 = User.create!(
  email: 'student@example.com',
  password: PASSWORD,
  first_name: 'Jane',
  last_name: 'Smith',
  role: 'student',
  is_subscriber: false
)

# Create events
event1 = Event.create!(
  creator: user1,
  category: 'Stage',
  price: 100,
  start_date: DateTime.now + 1.month,
  end_date: DateTime.now + 1.month + 1.day,
  location: 'New York',
  description: 'A grand music event.'
)

event2 = Event.create!(
  creator: user2,
  category: 'Concert',
  price: 50,
  start_date: DateTime.now + 2.months,
  end_date: DateTime.now + 2.months + 1.day,
  location: 'San Francisco',
  description: 'An inspiring art event.'
)

# Create instruments
instrument1 = Instrument.create!(name: 'Guitare')
instrument2 = Instrument.create!(name: 'Piano')
instrument3 = Instrument.create!(name: 'Basse')

# Create event instruments
EventInstrument.create!(
  event: event1,
  instrument: instrument1,
  total_spots: 10,
  available_spots: 8,
  level: 2
)

EventInstrument.create!(
  event: event1,
  instrument: instrument2,
  total_spots: 5,
  available_spots: 5,
  level: 3
)

EventInstrument.create!(
  event: event2,
  instrument: instrument3,
  total_spots: 15,
  available_spots: 10,
  level: 1
)

# Create skills
Skill.create!(
  musician: user1,
  instrument: instrument3,
  level: 1
)

Skill.create!(
  musician: user1,
  instrument: instrument2,
  level: 4
)

Skill.create!(
  musician: user2,
  instrument: instrument3,
  level: 3
)

puts "Database seeded successfully!"
