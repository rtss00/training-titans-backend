FactoryBot.define do
  factory :language do
    name { Faker::Nation.language }
    created_at { Date.today }
    updated_at { Date.today }
  end
end
