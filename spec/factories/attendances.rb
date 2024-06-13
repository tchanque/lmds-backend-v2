FactoryBot.define do
  factory :attendance do
    attendee { nil }
    event { nil }
    is_pending { false }
    instrument { nil }
  end
end
