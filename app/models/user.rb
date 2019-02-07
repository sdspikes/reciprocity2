class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchkick
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :outgoing, foreign_key: "checker_id", class_name: 'Check'
  has_many :incoming, foreign_key: "checked_id", class_name: 'Check'
  has_many :outgoing_checked, class_name: "User", through: :outgoing
  has_many :incoming_checked, class_name: "User", through: :incoming
  has_many :privacy_groups, foreign_key: "owner_id"
  has_many :profile_items
  has_many :profile_item_responses, through: :profile_items, source: :profile_item_data, source_type: 'ProfileItemResponse'
  has_many :text_profile_items, through: :profile_items, source: :profile_item_data, source_type: 'TextProfileItem'


  def activity_ids(user_id)
    activity_ids = []
    Activity.all.each do |activity|
      check = Check.find_by(activity_id: activity.id, checker: self, checked: user_id)
      if check 
        activity_ids.append(activity.id)
      end
    end
    activity_ids
  end

  def get_checks_for(user_id)
    activities = {}
    Activity.all.each do |activity|
      check = Check.find_by(activity_id: activity.id, checker: self, checked_id: user_id)
      activities[activity.id] = check ? check.id : nil
    end
    activities
  end


  def get_checks_table
    users_to_activities = Hash[ User.all.collect do |u|
      [u.id, Hash[ Activity.all.collect { |activity| [activity.id, {status: :unchecked}] }]]
    end]

    outgoing.each { |check| users_to_activities[check.checked_id][check.activity_id] = {
      status: :checked,
      check_id: check.id
    } }
    incoming.each do |check|
      if users_to_activities[check.checker_id][check.activity_id][:status] == :checked then
        users_to_activities[check.checker_id][check.activity_id][:status] = :reciprocated
      end
    end
    users_to_activities
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end
