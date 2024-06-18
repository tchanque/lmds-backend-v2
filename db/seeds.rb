require File.join(Dir.pwd, 'app/models/event')
CATEGORIES = Event::CATEGORIES

# Clear existing data
Attendance.destroy_all
Publication.destroy_all
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
  role: 'Professeur',
  is_subscriber: true,
  subscription_end_date: DateTime.now + 1.year
)

user2 = User.create!(
  email: 'admin@example.com',
  password: PASSWORD,
  first_name: 'Jane',
  last_name: 'Smith',
  role: 'Admin',
  is_subscriber: false,
  subscription_end_date: DateTime.now + 1.year
)

user3 = User.create!(
  email: 'student@example.com',
  password: PASSWORD,
  first_name: 'Jane',
  last_name: 'Smith',
  role: 'Etudiant',
  is_subscriber: false,
  subscription_end_date: DateTime.now + 1.year
)

# Create events
5.times do |i|
  Event.create!(
    creator: User.all.sample,
    category: CATEGORIES.sample,
    price: rand(100),
    start_date: DateTime.now + 1.month,
    end_date: DateTime.now + 1.month + 1.day,
    location: 'New York',
    description: 'A grand music event.'
  )
end

# Create publications
5.times do |i|
  Publication.create!(
    creator: User.all.sample,
    title: Faker::Lorem.sentence(word_count: 1),
    description: Faker::Lorem.sentence(word_count: 2),
    to_display: [true, false].sample
  )
end

# Create instruments
instrument1 = Instrument.create!(name: 'Guitare')
instrument2 = Instrument.create!(name: 'Piano')
instrument3 = Instrument.create!(name: 'Basse')

# Create event instruments
10.times do |i|
  EventInstrument.create!(
    event: Event.all.sample,
    instrument: Instrument.all.sample,
    total_spots: 5,
    available_spots: 5,
    level: rand(5)
  )
end

# Create skills
5.times do |i|
  Skill.create!(
    musician: User.all.sample, 
    instrument: Instrument.all.sample,
    level: rand(6)
  )
end

5.times do |i|
  Attendance.create!(
    attendee: User.all.sample, 
    event: Event.all.sample,
    is_pending: [true, false].sample,
    event_instrument: EventInstrument.all.sample
  )
end

puts "Database seeded successfully!"
