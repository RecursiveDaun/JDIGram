class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string  :name
      t.integer :age
      t.timestamps
    end
  end
end
