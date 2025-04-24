# frozen_string_literal: true

class AddDeletedAtToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :deleted_at, :datetime
    add_index :messages, :deleted_at
  end
end
