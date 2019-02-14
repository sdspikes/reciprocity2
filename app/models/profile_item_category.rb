class ProfileItemCategory < ApplicationRecord
	has_many :profile_items
	has_many :profile_item_responses
	enum item_type: %i[text multi integer]
end
