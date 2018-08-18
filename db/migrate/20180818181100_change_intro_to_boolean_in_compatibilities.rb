class ChangeIntroToBooleanInCompatibilities < ActiveRecord::Migration[5.2]
  def up
  	change_column :compatibilities, :introduction_made, 'boolean USING CAST(introduction_made AS boolean)', :default => false
  end

  def down
    change_column :compatibilities, :introduction_made, :string
  end
end
