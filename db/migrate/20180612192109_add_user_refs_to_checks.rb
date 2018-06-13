class AddUserRefsToChecks < ActiveRecord::Migration[5.2]
  def change
    add_reference :checks, :checker, foreign_key: { to_table: :users }
    add_reference :checks, :checked, foreign_key: { to_table: :users }
  end
end
