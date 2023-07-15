class Requirement < ApplicationRecord
  belongs_to :profile
  belongs_to :technology

  enum :seniority, %i(junior semisenior senior)
end
