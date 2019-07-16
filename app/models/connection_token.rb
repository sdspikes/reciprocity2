class ConnectionToken < ApplicationRecord
  has_secure_token
  belongs_to :user
  before_create :set_default_expiration
  has_many :connection_requests, as: :source, dependent: :destroy
  has_many :connections, as: :source, dependent: :destroy

  def set_default_expiration
    if (!expires_at)
      self.expires_at = DateTime.now + 1
    end
  end

  def reactivate
    self.expires_at = DateTime.now + 1
    self.save
  end

  def expired?
    DateTime.now > self.expires_at
  end
end
