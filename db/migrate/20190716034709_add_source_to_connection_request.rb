class AddSourceToConnectionRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :connection_requests, :source, index: true
    add_column :connection_requests, :source_type, :string
    add_index :connection_requests, [:requester_id, :requestee_id], unique: true
    add_index :connection_requests, [:requestee_id, :requester_id], unique: true
    add_column :connection_requests, :ignored, :boolean, default: false

    add_reference :connections, :source, index: true
    add_column :connections, :source_type, :string
    add_index :connections, [:requestee_id, :requester_id], unique: true
    add_index :connections, [:requester_id, :requestee_id], unique: true
  end
end
