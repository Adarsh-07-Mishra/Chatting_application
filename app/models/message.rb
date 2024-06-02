class Message < ApplicationRecord
  # acts_as_paranoid
  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant
  after_create :schedule_deletion

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end

  private

  def schedule_deletion
    DeleteMessageJob.set(wait: 7.hours).perform_later(self.id)
  end
end