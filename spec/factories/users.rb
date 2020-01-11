FactoryBot.define do
  factory :user do
    auth_token { Faker::Lorem.characters(number: 30) }
    username { Faker::Internet.username(specifier: 3..10, separators: %w(_)) }
    quotes_token { SecureRandom.hex(15) }
    quotes_api_count { 10 }
  end
end
