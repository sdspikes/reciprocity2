class CreateConnectionTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :connection_tokens do |t|
      t.references :user
      t.string :name
      t.string :token
      t.timestamp :expires_at

      t.timestamps
    end
    add_index :connection_tokens, :token, unique: true
  end
end
