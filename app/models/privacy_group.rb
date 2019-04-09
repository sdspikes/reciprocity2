class PrivacyGroup < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :profile_items, as: :privacy_setting
  has_many :privacy_group_members, :dependent => :destroy
end
