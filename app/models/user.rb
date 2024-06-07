class User < ApplicationRecord

  has_secure_password
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :username
   validates :username, presence: true, length: { minimum: 1 }
   validates :username, presence: true, length: { minimum: 1 }
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }

  def self.ransackable_associations(auth_object = nil)
    ["messages"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "password_digest", "updated_at", "username"]
  end
end
