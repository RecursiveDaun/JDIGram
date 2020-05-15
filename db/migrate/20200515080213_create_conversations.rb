class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :author_id
      t.integer :receiver_id
      t.timestamps
    end
  end
end
