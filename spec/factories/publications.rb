FactoryBot.define do
  factory :publication do
    association :creator, factory: :user
    title { "MyString" }
    description { "MyText" }
    to_display { true }
  end
end
