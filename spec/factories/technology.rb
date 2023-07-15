FactoryBot.define do
  factory :technology do
    name { Faker::App.name } 
    description { Faker::Lorem.paragraphs(sentence_count: rand(2..4)) }
  end
end
