class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  validates :name, :description, :location, :date, :creator_id, presence: true
  validates :name, length: { maximum: 100 }
end
