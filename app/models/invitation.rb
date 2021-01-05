class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, foreign_key: :user_id, class_name: 'User'
end
