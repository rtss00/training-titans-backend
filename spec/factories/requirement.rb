FactoryBot.define do
  factory :requirement do
    profile
    technology
    seniority { [nil, :senior, :semisenior, :junior].sample }
  end
end
