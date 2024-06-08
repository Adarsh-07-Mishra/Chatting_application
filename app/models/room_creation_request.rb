class RoomCreationRequest < ApplicationRecord
  belongs_to :user
  enum status: { pending: 0, approved: 1, rejected: 2 }
  validates :name, presence: true, length: { minimum: 4, message: "must be at least 4 words long" }

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "status", "updated_at", "user_id"]
  end

end
