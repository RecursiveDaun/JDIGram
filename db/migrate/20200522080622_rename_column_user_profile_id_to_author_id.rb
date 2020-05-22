class RenameColumnUserProfileIdToAuthorId < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :user_profile_id, :author_id
    rename_column :comments, :user_profile_id, :author_id
  end
end
