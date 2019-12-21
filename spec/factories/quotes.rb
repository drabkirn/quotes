FactoryBot.define do
  factory :quote do
    title { Faker::Lorem.sentence(word_count: 5) }
    content { Faker::Lorem.sentence(word_count: 12) }
    author { Faker::Name.name }
    tags { Faker::Lorem.words(number: 4) }
    #=> ["culpa", "recusandae", "aut", "omnis"]
  end
end
