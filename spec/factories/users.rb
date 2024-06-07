# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { "test@example.com" }
      password { "Password1!" }
    end
  end
  