# frozen_string_literal: true

class DeleteMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find_by(id: message_id)
    message&.destroy
  end
end
