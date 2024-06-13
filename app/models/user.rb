class User < ApplicationRecord
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :room_creation_requests, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rooms, through: :participants

  validates :username, presence: true, uniqueness: true, length: { minimum: 1 }

  scope :all_except, ->(user) { where.not(id: user&.id) }

  after_create_commit { broadcast_append_to 'users' }

  def self.ransackable_associations(auth_object = nil)
    ["messages", "room_creation_requests", "participants", "rooms"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "password_digest", "updated_at", "username"]
  end
end
