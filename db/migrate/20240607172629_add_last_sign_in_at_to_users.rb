# frozen_string_literal: true

class AddLastSignInAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_sign_in_at, :datetime
  end
end
