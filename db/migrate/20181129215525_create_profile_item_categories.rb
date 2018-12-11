class CreateProfileItemCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_item_categories do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
