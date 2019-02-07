class CreatePrivacyGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :privacy_group_members do |t|
      t.references :privacy_group, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
