class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)  
    elsif @user
      @error_message = 'Incorrect password. Please try again.'
      render 'new', status: :unprocessable_entity
    else
      @user = User.new(username: params[:session][:username], password: params[:session][:password])
      
      if @user.save
        log_in(@user)
        UserNotificationMailer.welcome_email(@user).deliver_now
      else
        @error_message = 'There was an error creating the user. Username must be at least 5 characters long and password must be at least 6 characters long.'
        render 'new', status: :unprocessable_entity
      end
    end
  end

  def destroy
    log_out if logged_in?
    @notice_message = 'Logged out successfully.'
    render 'new'
  end  
end
