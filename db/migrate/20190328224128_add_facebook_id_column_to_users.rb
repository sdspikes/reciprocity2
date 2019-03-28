class AddFacebookIdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :facebook_id, :integer
    add_index :users, :facebook_id
  end
end
