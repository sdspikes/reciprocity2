class RenameProfileItemPrivacyGroupToPrivacySetting < ActiveRecord::Migration[5.2]
  def change
    rename_column :profile_items, :privacy_group_id, :privacy_setting_id
    add_column :profile_items, :privacy_setting_type, :string, after: :id, default: 'PrivacyGroup'
  end
end
