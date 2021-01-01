class User < ApplicationRecord
  has_many :events, foreign_key: 'creator_id', class_name: 'Event'
  has_many :invitations
  has_many :invites, through: :invitations, source: :event

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
