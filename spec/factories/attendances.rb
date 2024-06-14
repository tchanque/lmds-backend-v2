FactoryBot.define do
  factory :attendance do
    association :attendee, factory: :user
    association :event, factory: :event
    is_pending { false }
    association :event_instrument, factory: :event_instrument
  end
end
