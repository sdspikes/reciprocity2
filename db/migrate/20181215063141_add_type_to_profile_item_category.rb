class AddTypeToProfileItemCategory < ActiveRecord::Migration[5.2]
  def change
  	add_column :profile_item_categories, :item_type, :integer, default: 0
  end
end
