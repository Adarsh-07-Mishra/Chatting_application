class CreateRoomCreationRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :room_creation_requests do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
