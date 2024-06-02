class SessionsController < ApplicationController
  def create
    @user = User.find_or_initialize_by(username: params[:session][:username])
    if @user.persisted?
      log_in(@user)
    elsif @user.save
      log_in(@user)
      UserNotificationMailer.welcome_email(@user).deliver_now
    else
      flash.now[:alert] = 'There was an error creating the user. Username must be at least 5 characters long.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
