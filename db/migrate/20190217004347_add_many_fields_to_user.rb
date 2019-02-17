class AddManyFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :string
    add_column :users, :relationship_style, :string
    add_column :users, :current_relationships, :string
    add_column :users, :bio, :text
  end
end
