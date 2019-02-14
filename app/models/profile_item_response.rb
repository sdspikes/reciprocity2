class ProfileItemResponse < ApplicationRecord
  belongs_to :profile_item_category
  has_many :profile_items, as: :profile_item_data
end
