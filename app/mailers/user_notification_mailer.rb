class UserNotificationMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      mail(to: 'aadimishra277@gmail.com', subject: 'Welcome to Our App!')
    end
  end
  