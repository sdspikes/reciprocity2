class CreateProfileItemResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_item_responses do |t|
      t.string :value
      t.references :profile_item_category, foreign_key: true

      t.timestamps
    end
  end
end
