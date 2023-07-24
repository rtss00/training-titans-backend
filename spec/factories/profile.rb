FactoryBot.define do
  factory :profile do
    description { Faker::Lorem.paragraph(sentence_count: rand(2..8)) }
    created_at { Date.today }
    updated_at { Date.today }
    language

    factory :profile_with_requirements do
      transient do
        requirements_count { 3 }
      end

      after :create do |requirement, evaluator|
        create_list :requirement, evaluator.requirement_count, requirement: requirement
        requirement.reload
      end
    end
  end
end
