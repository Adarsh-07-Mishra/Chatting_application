ActiveAdmin.register User do
  permit_params :username, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :gender
    column :last_sign_in_at
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :created_at
      row :updated_at
    end

    panel "Messages" do
      table_for user.messages do
        column :content
        column :created_at
        column :room
      end
    end
  end

  filter :username
  filter :created_at

  

  form do |f|
    f.inputs do
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
