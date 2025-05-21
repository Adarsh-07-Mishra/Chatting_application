# frozen_string_literal: true

class UserNotificationMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: 'convospace07@gmail.com')
  end
end
