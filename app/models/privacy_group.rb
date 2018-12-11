class PrivacyGroup < ApplicationRecord
  belongs_to :owner, class_name: :user
  has_many :profile_items
  has_many :privacy_group_members
end
