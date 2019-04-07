class ProfileItem < ApplicationRecord
  belongs_to :user
  belongs_to :privacy_group, optional: true
  belongs_to :profile_item_category
  belongs_to :profile_item_data, polymorphic: true
  accepts_nested_attributes_for :profile_item_data

  def self.get_viewable(user, viewer)
    # only show if it's the viewer's profile, there's no privacy group set (public)
    # or the viewer is in a privacy groups belonging to the user
    viewable_items = user.profile_items.to_a.select do |item|
      viewer == user || !item.privacy_group ||
        item.privacy_group.privacy_group_members.pluck(:user_id).include?(viewer.id)
    end
  end

  def build_profile_item_data(params)
    raise "Unknown profile_item_data_type: #{profile_item_data_type}" unless PROFILE_ITEM_DATA_TYPES.include?(profile_item_data_type)
    self.profile_item_data = profile_item_data_type.constantize.create(params)
  end
end
