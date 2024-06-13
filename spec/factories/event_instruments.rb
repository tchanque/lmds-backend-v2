FactoryBot.define do
  factory :event_instrument do
    event { nil }
    instrument { nil }
    total_spots { 1 }
    available_spots { 1 }
    level { 1 }
  end
end
