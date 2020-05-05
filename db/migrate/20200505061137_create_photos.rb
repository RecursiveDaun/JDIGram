class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string  :filename
      t.string  :image_type
      t.binary  :data
      t.integer :user_profile_id
      t.timestamps
    end
  end
end
