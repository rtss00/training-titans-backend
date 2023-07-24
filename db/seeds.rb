# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Rails.env.development?
  # Admin Users
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  # Technologies
  technology_1 = Technology.create!(
    name: 'Scrum', 
    description: 'Scrum is an agile project management system commonly used in software development')
  technology_2 = Technology.create!(
    name: 'React', 
    description: 'React is a free and open-source front-end JavaScript library for building user interfaces based on components.')
  technology_3 = Technology.create!(
    name: 'TypeScript', 
    description: 'TypeScript is a free and open-source high-level programming language developed by Microsoft that adds static typing with optional type annotations to JavaScript.')

  # Languages
  language_1 = Language.create!(name: "English")
  language_2 = Language.create!(name: "Spanish")

  # Job Description Profile
  profile_1 = Profile.create!(
    name: "Test Profile 1",
    area: "Senior Frontend",
    description: 'The candidate is an MIT graduate with 10 years of experience in software development using React.',
    language: language_1)
  
  # Candidate profile
  profile_2 = Profile.create!(
    name: "Test Profile 2",
    area: "Senior Backend",
    description: 'The candidate is an university undergraduate with 3 years of experience in software development.',
    language: language_1)

  # Requirements for profile 1 (used as target)
  requirement_1 = Requirement.new(seniority: nil)
  requirement_1.profile = profile_1
  requirement_1.technology = technology_1

  requirement_2 = Requirement.new(seniority: :senior)
  requirement_2.profile = profile_1
  requirement_2.technology = technology_2

  requirement_3 = Requirement.new(seniority: :senior)
  requirement_3.profile = profile_1
  requirement_3.technology = technology_3

  # Requirements for profile 2 (used as candidate)
  requirement_4 = Requirement.new(seniority: :semisenior)
  requirement_4.profile = profile_2
  requirement_4.technology = technology_1

  requirement_5 = Requirement.new(seniority: :semisenior)
  requirement_5.profile = profile_2
  requirement_5.technology = technology_2

  [requirement_1, requirement_2, requirement_3, requirement_4, requirement_5].each do |requirement|
    requirement.save!
  end

  # Sessions
  Session.create!
end
