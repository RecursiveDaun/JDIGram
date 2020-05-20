class ChangeFriendshipFieldsToReferences < ActiveRecord::Migration[5.2]
  def change
    remove_column :friendships, :owner_id, :integer
    add_column :friendships, :owner_id, :integer, references: :user_profile

    remove_column :friendships, :follower_id, :integer
    add_column :friendships, :follower_id, :integer, references: :user_profile
  end
end
