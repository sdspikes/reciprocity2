class AddFacebookTokenColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :facebook_token, :string
  end
end
