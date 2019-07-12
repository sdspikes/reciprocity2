class Connection < ApplicationRecord
  belongs_to :connecter, class_name: 'User', foreign_key: 'requester_id'
  belongs_to :connectee, class_name: 'User', foreign_key: 'requestee_id'

  def other_user(user)
    user == connectee ? connecter : connectee
  end
end
