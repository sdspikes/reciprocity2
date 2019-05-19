class ProfileItemCategory < ApplicationRecord
	has_many :profile_items
	has_many :profile_item_responses
	enum item_type: %i[text multi integer]

  def create_profile_item
    ProfileItem.new(
      profile_item_category_id: :id,
      profile_item_data_type: p)
  end
end
