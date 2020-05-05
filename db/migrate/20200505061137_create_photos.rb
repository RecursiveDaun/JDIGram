class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string  :filename
      t.string  :name
      t.string  :type
      t.binary  :data
      t.integer :profile_id
      t.timestamps
    end
  end
end
