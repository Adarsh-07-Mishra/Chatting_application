# frozen_string_literal: true

ActiveAdmin.register Room do
  permit_params :name

  # Scope to filter out private rooms
  scope :all, default: true do |rooms|
    rooms.where(is_private: false)
  end

  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end

    panel 'Messages' do
      table_for room.messages do
        column :id
        column :content
        column :user
        column :created_at
        column :updated_at
      end
    end
  end
end
