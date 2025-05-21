# frozen_string_literal: true

class EmailMailer < ApplicationMailer
    def notification_email(user, message)
        @user = user
        @message = message
        mail(to: @user.email, subject: 'You received a new message')
    end
  end
  