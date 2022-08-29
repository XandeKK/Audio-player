class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, limit: 64, null: false
    add_column :users, :artistic_name, :string, limit: 64, unique: true
  end
end
