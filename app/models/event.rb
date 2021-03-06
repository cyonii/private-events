class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee

  validates :name, :description, :location, :date, :creator_id, presence: true
  validates :name, length: { maximum: 100 }

  scope :upcoming, -> { where('date >= ?', Date.today).order(date: :ASC) }
  scope :past, -> { where('date < ?', Date.today).order(date: :DESC) }
end
