class ConnectionToken < ApplicationRecord
  has_secure_token
  belongs_to :user
  before_create :set_default_expiration

  def set_default_expiration
    if (!expires_at)
      self.expires_at = DateTime.now + 1
    end
  end

  def expired?
    DateTime.now > self.expires_at
  end
end
