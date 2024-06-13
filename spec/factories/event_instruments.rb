FactoryBot.define do
  factory :event_instrument do
    association :event, factory: :event
    association :instrument, factory: :instrument
    total_spots { 1 }
    available_spots { 1 }
    level { 1 }
  end
end
