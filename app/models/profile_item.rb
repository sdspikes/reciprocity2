class ProfileItem < ApplicationRecord
  belongs_to :user
  belongs_to :privacy_group, optional: true
  belongs_to :profile_item_category
  belongs_to :profile_item_data, polymorphic: true
end
