# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:session][:username])

    if @user&.authenticate(params[:session][:password])
      log_in(@user)
    elsif @user
      @error_message = 'Incorrect password. Please try again.'
      render 'new', status: :unprocessable_entity
    else
      @user = User.new(username: params[:session][:username], password: params[:session][:password],
                       gender: params[:session][:gender])
      if @user.save
        log_in(@user)
        UserNotificationMailer.welcome_email(@user).deliver_now
      else
        @error_message = 'There was an error creating the user. Username must be at least 5 characters long and password must be at least 4 characters long and selection of gender must be included.'
        render 'new', status: :unprocessable_entity
      end
    end
  end

  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      is_new_user = user.created_at == user.updated_at
      user.username = user.email.split('@').first
      user.save
      session[:user_id] = user.id
      UserNotificationMailer.welcome_email(user).deliver_now if is_new_user

      redirect_to root_path
    else
      redirect_to root_path, alert: 'Failed to sign in'
    end
  end

  def destroy
    log_out if logged_in?
    @notice_message = 'Logged out successfully.'
    render 'new'
  end
end
