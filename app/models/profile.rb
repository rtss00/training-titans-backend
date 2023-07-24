class Profile < ApplicationRecord
  has_many :requirements
  belongs_to :language

  accepts_nested_attributes_for :requirements, allow_destroy: false

  validates :description, presence: :true
end
