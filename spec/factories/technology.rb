FactoryBot.define do
  factory :technology do
    name { Faker::App.name } 
    description { Faker::Lorem.sentence(word_count: rand(4..8)) }
    created_at { Date.today }
    updated_at { Date.today }
  end
end
