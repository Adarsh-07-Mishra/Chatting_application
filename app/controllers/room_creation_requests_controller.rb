class RoomCreationRequestsController < ApplicationController
    def create
      @room_creation_request = current_user.room_creation_requests.build(room_creation_request_params)
      if @room_creation_request.save
        redirect_to root_path, notice: "Room creation request submitted successfully!."
      else
       redirect_to rooms_path, alert: "Failed to submit room creation request,RoomName must be minimum 4 characters long!"
      end
    end
  
    private
  
    def room_creation_request_params
      params.require(:room_creation_request).permit(:name)
    end
  end