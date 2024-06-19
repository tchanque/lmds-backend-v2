require File.join(Dir.pwd, 'app/models/event')
require File.join(Dir.pwd, 'app/models/instrument')

CATEGORIES = Event::CATEGORIES
INSTRUMENTS = Instrument::INSTRUMENTS
PASSWORD = "Coucou!123"

# Clear existing data
Attendance.destroy_all
Publication.destroy_all
EventInstrument.destroy_all
Skill.destroy_all
Event.destroy_all
Instrument.destroy_all
User.destroy_all

# Create instruments
INSTRUMENTS.each do |instrument|
  Instrument.create!(
    name: instrument
  )
end

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
    title: Faker::Lorem.sentence(word_count: 4),
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
    to_display: [true].sample
  )
end

# Create event instruments
10.times do |i|
  EventInstrument.create!(
    event: Event.all.sample,
    instrument: Instrument.all.sample,
    total_spots: 5,
    available_spots: 5,
    level: rand(5).to_s
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
