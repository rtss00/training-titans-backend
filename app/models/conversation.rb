class Conversation < ApplicationRecord
  has_many :messages
  belongs_to :candidate_profile, class_name: 'Profile'
  belongs_to :target_profile, class_name: 'Profile'
  belongs_to :session

  accepts_nested_attributes_for :messages, allow_destroy: true
end
