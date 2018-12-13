class RenameGenderNameToValue < ActiveRecord::Migration[5.2]
  def change
  	rename_column :genders, :name, :value
  end
end
