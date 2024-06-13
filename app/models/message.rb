class Message < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant
  after_create :schedule_deletion

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "deleted_at", "id", "room_id", "updated_at", "user_id"]
  end

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.exists?(user_id: user.id, room_id: room.id)
    throw(:abort) unless is_participant
  end

  private

  def schedule_deletion
    DeleteMessageJob.set(wait: 7.hours).perform_later(id)
  end
end
