class ConnectionRequest < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :requestee, class_name: "User", foreign_key: :requestee_id
  belongs_to :source, class_name: :source, polymorphic: true, optional: true
end
