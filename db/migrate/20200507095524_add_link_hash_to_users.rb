class AddLinkHashToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :link_hash, :string
  end
end
