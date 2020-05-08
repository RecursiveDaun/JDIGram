class RemoveUserProfileIdAndAddPostIdToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :post_id, :integer
    remove_column :photos, :user_profile_id
  end
end
