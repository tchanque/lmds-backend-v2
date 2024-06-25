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
  subscription_end_date: DateTime.now + 1.year,
  description: Faker::Lorem.sentence(word_count: 10)
)

user2 = User.create!(
  email: 'admin@example.com',
  password: PASSWORD,
  first_name: 'Jane',
  last_name: 'Smith',
  role: 'Admin',
  is_subscriber: false,
  subscription_end_date: DateTime.now + 1.year,
  description: Faker::Lorem.sentence(word_count: 10)
)

user3 = User.create!(
  email: 'student@example.com',
  password: PASSWORD,
  first_name: 'Jane',
  last_name: 'Smith',
  role: 'Etudiant',
  is_subscriber: false,
  subscription_end_date: DateTime.now + 1.year,
  description: Faker::Lorem.sentence(word_count: 10)
)

3.times do |i|
  event = Event.create!(
    creator: User.all.sample,
    category: CATEGORIES.sample,
    title: Faker::Lorem.sentence(word_count: 4),
    price: rand(100),
    start_date: DateTime.now + 1.month,
    end_date: DateTime.now + 1.month + 1.day,
    location: 'New York',
    description: 'A grand music event.'
  )

  # Create different EventInstruments (not "Aucun")
  2.times do
    EventInstrument.create!(
      event: event,
      instrument: Instrument.where.not(name: "Aucun").sample,
      total_spots: 1,
      available_spots: 1,
      level: rand(5).to_s
    )
  end
end

# Create events with one EventInstrument "Aucun"
2.times do |i|
  event = Event.create!(
    creator: User.all.sample,
    category: CATEGORIES.sample,
    title: Faker::Lorem.sentence(word_count: 4),
    price: rand(100),
    start_date: DateTime.now + 1.month,
    end_date: DateTime.now + 1.month + 1.day,
    location: 'New York',
    description: 'A grand music event.'
  )

  # Create one EventInstrument with instrument "Aucun"
  EventInstrument.create!(
    event: event,
    instrument: Instrument.find_by(name: "Aucun"),
    total_spots: 999,
    available_spots: 999,
    level: rand(5).to_s
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

# Create skills
5.times do |i|
  Skill.create!(
    musician: User.all.sample, 
    instrument: Instrument.all.sample,
    level: rand(6)
  )
end

# 5.times do |i|
#   Attendance.create!(
#     attendee: User.all.sample, 
#     event: Event.all.sample,
#     is_pending: [true, false].sample,
#     event_instrument: EventInstrument.all.sample
#   )
# end


puts "Database seeded successfully!"
