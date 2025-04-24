# frozen_string_literal: true

class DeleteInactiveUsersJob < ApplicationJob
  queue_as :default

  def perform
    inactive_users = User.where('last_sign_in_at < ?', 15.days.ago)
    inactive_users.each(&:destroy)
  end
end
