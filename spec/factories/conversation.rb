FactoryBot.define do
  factory :conversation do
    association :target_profile, factory: :profile
    association :candidate_profile, factory: :profile
    association :session
  end
end
