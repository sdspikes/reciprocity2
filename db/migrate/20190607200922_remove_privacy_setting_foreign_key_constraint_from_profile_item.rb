class RemovePrivacySettingForeignKeyConstraintFromProfileItem < ActiveRecord::Migration[5.2]
  def change
      remove_foreign_key :profile_items, :privacy_groups
  end
end
