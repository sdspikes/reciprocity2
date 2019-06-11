class AddDefaultPrivacySettingToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :default_privacy_setting, index: true
    add_column :users, :default_privacy_setting_type, :string, after: :id, default: 'PrivacyPreset'
  end
end
