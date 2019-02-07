class CreateProfileItems < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_items do |t|
      t.references :user, foreign_key: true
      t.references :privacy_group, foreign_key: true
      t.references :profile_item_category, foreign_key: true
      t.references :profile_item_data, polymorphic: true, index: { name: 'profile_item_data_id' }

      t.timestamps
    end
  end
end
