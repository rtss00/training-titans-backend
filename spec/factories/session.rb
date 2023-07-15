FactoryBot.define do
  factory :session do
    created_at { Date.today }
    updated_at { Date.today }
  end
end
