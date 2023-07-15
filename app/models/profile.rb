class Profile < ApplicationRecord
  has_many :requirements

  accepts_nested_attributes_for :requirements, allow_destroy: true

  validates :description, presence: :true
end
