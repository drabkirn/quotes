FactoryBot.define do
  factory :user do
    auth_token { Faker::Lorem.characters(number: 30) }
    username { Faker::Internet.username(specifier: 3..10, separators: %w(_)) }
  end
end
