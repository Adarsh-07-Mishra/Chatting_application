# frozen_string_literal: true

ActiveAdmin.register RoomCreationRequest do
  permit_params :name, :user_id, :status

  index do
    selectable_column
    column :name
    column :user
    column :status
    actions
  end

  form do |f|
    f.inputs 'Room Creation Request Details' do
      f.input :name
      f.input :user
      f.input :status, as: :select, collection: RoomCreationRequest.statuses.keys
    end
    f.actions
  end

  member_action :approve, method: :put do
    room_creation_request = RoomCreationRequest.find(params[:id])
    room_creation_request.update(status: :approved)
    Room.create(name: room_creation_request.name)
    redirect_to admin_room_creation_requests_path, notice: 'Room creation request approved.'
  end

  member_action :reject, method: :put do
    room_creation_request = RoomCreationRequest.find(params[:id])
    room_creation_request.update(status: :rejected)
    redirect_to admin_room_creation_requests_path, notice: 'Room creation request rejected.'
  end

  action_item :approve, only: :show do
    link_to 'Approve', approve_admin_room_creation_request_path(room_creation_request), method: :put
  end

  action_item :reject, only: :show do
    link_to 'Reject', reject_admin_room_creation_request_path(room_creation_request), method: :put
  end
end
