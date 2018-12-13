class CreateTextProfileItems < ActiveRecord::Migration[5.2]
  def change
    create_table :text_profile_items do |t|
      t.string :value

      t.timestamps
    end
  end
end
