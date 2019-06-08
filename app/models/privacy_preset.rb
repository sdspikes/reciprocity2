class PrivacyPreset < ApplicationRecord
  has_many :profile_items, as: :privacy_setting, dependent: :destroy
end
