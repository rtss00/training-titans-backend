FactoryBot.define do
  factory :conversation do
    association :session

    after(:build) do |conversation|
      profile = create(:profile, language: Language.first || create(:language))
      conversation.target_profile = profile
      conversation.candidate_profile = profile
    end
  end
end
