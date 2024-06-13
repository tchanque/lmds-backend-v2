FactoryBot.define do
  factory :publication do
    creator { nil }
    title { "MyString" }
    description { "MyText" }
    to_display { false }
  end
end
