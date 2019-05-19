class PrivacyGroup < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :profile_items, dependent: :destroy
  has_many :privacy_group_members, :dependent => :destroy

  def self.create_facebook_group(token)
    current_user = User.find_by(facebook_token: token)
    unless !PrivacyGroup.find_by(name: "Facebook Friends", owner_id: current_user.id)
      @privacy_group = PrivacyGroup.find_by(name: "Facebook Friends", owner_id: current_user.id)
    end
    @privacy_group ||= PrivacyGroup.create(name: "Facebook Friends", owner_id: current_user.id)

    friend_list = Facebook.get_connections(current_user.facebook_token, "me", "friends").map {|node| node["id"]}
    friend_list.each do |friend|
      user = User.find_by(uid: friend)
      unless PrivacyGroupMember.find_by(privacy_group_id: @privacy_group.id, user_id: user.id)
        PrivacyGroupMember.create(privacy_group_id: @privacy_group.id, user_id: user.id)
      end
    end
    return @privacy_group
  end
end
