class Gender < ApplicationRecord
	has_many :profile_items, as: :profile_item_data
end
