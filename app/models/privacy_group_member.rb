class PrivacyGroupMember < ApplicationRecord
  belongs_to :privacy_group
  belongs_to :user
end
