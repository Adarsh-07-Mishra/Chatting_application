# frozen_string_literal: true

class AddForeignKeyConstraintsToMessages < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :messages, :rooms
    remove_foreign_key :messages, :users

    add_foreign_key :messages, :rooms, on_delete: :cascade
    add_foreign_key :messages, :users, on_delete: :cascade
  end
end
