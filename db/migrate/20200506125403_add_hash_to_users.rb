class AddHashToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ten_symbols_hash, :string
  end
end
