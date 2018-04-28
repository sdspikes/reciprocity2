class ConnectionRequest < ApplicationRecord
  belongs_to :user, foreign_key: 'requester_id'
  belongs_to :user, foreign_key: 'requestee_id'
end
