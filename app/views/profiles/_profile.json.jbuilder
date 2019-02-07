json.extract! profile_item, :id, :user_id, :profile_item_category, :privacy_group_id, :data_id, :created_at, :updated_at
json.url profile_item_url(profile_item, format: :json)
