# frozen_string_literal: true

class RoomCreationRequest < ApplicationRecord
  belongs_to :user
  enum status: { pending: 0, approved: 1, rejected: 2 }
  validates :name, presence: true, length: { minimum: 4, message: 'must be at least 4 words long' }

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name status updated_at user_id]
  end
end
