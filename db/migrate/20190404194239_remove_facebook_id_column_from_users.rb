class RemoveFacebookIdColumnFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :facebook_id
  end
end
