# frozen_string_literal: true

ActiveAdmin.register_page 'Messages' do
  menu priority: 2, label: 'All Messages'

  content title: 'All Messages' do
    panel 'Messages' do
      table_for Message.unscoped.order(created_at: :desc) do
        column :user do |message|
          link_to message.user.username, admin_user_path(message.user)
        end
        column :content
        column :created_at
        column :room
        column :action do |message|
          if message.deleted_at?
            status_tag "Deleted at #{message.deleted_at.strftime('%Y-%m-%d %H:%M:%S')}", class: 'deleted'
          else
            status_tag 'Active', class: 'active'
          end
        end
      end
    end
  end
end
