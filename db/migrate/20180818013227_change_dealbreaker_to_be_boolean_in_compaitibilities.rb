class ChangeDealbreakerToBeBooleanInCompaitibilities < ActiveRecord::Migration[5.2]
  def up
  	change_column :compatibilities, :dealbreaker, 'boolean USING CAST(dealbreaker AS boolean)', :default => false
  end

  def down
    change_column :compatibilities, :dealbreaker, :string
  end
end
