class Message < ApplicationRecord
  belongs_to :conversation

  enum :actor, %i(interviewer candidate)

  validates :actor, presence: true
  validates :content, presence: true, allow_blank: false
end
