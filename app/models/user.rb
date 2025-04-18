class User < ApplicationRecord
  has_secure_password  # Disable password validation unless manually handled

  has_many :messages, dependent: :destroy
  has_many :room_creation_requests, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rooms, through: :participants

  validates :username, presence: true, uniqueness: true, length: { minimum: 1 }, unless: :google_account?
  validates :gender, presence: true, inclusion: { in: %w(male female) }, unless: :google_account?

  validates :password, presence: true, on: :create, unless: :google_account?

  scope :all_except, ->(user) { where.not(id: user&.id) }

  after_create_commit { broadcast_append_to 'users' }

  def self.from_omniauth(auth)
      where(uid: auth['uid'], provider: auth['provider']).first_or_initialize.tap do |user|
        user.name = auth['info']['name']
        user.email = auth['info']['email']
        user.password = SecureRandom.hex(15)
        user.save!
      end
    end

  def self.ransackable_associations(auth_object = nil)
    ["messages", "room_creation_requests", "participants", "rooms"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "password_digest", "updated_at", "username"]
  end

  def google_account?
    provider == 'google_oauth2'
  end
end
