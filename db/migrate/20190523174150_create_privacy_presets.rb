class CreatePrivacyPresets < ActiveRecord::Migration[5.2]
  def change
    create_table :privacy_presets do |t|
      t.string :name

      t.timestamps
    end
  end
end
