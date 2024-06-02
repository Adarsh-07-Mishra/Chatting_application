class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :username
   validates :username, presence: true, length: { minimum: 1 }
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }
end
