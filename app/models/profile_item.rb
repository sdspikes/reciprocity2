class ProfileItem < ApplicationRecord
  belongs_to :user
  belongs_to :privacy_setting, polymorphic: true
  belongs_to :profile_item_category
  belongs_to :profile_item_data, polymorphic: true

  accepts_nested_attributes_for :profile_item_data

  def self.get_viewable(user, viewer)
    viewable_items = user.profile_items.to_a.select do |item|
      if (item.privacy_setting_type == "PrivacyGroup")

        # only show if it's the viewer's profile,
        # there's no privacy group set (public)
        # or the viewer is in a privacy groups belonging to the user
        viewer == user || !item.privacy_setting ||
          item.privacy_setting.privacy_group_members.pluck(:user_id).include?(viewer.id)
      else
        if (item.privacy_setting.name == "Public")
          true
        elsif (item.privacy_setting.name == "Only Me")
          viewer == user
        elsif (item.privacy_setting.name == "All Connections")
          true # TODO: actually check that they are connected
        else
          p "unknown privacy preset, ", item.privacy_setting.name
          false
        end

        # preset_groups = ['Only Me', 'All Connections', 'Public']

      end
    end
  end

  def build_profile_item_data(params)
    raise "Unknown profile_item_data_type: #{profile_item_data_type}" unless PROFILE_ITEM_DATA_TYPES.include?(profile_item_data_type)
    self.profile_item_data = profile_item_data_type.constantize.create(params)
  end
end
