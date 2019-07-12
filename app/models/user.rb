class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :outgoing, foreign_key: "checker_id", class_name: 'Check', :dependent => :destroy
  has_many :incoming, foreign_key: "checked_id", class_name: 'Check', :dependent => :destroy
  has_many :outgoing_checked, class_name: "User", through: :outgoing
  has_many :incoming_checked, class_name: "User", through: :incoming

  has_many :privacy_groups, foreign_key: "owner_id", :dependent => :destroy
  has_many :profile_items, :dependent => :destroy
  has_many :profile_item_responses, through: :profile_items, source: :profile_item_data, source_type: 'ProfileItemResponse'
  has_many :text_profile_items, through: :profile_items, source: :profile_item_data, source_type: 'TextProfileItem', :dependent => :destroy
  has_many :privacy_group_members, dependent: :destroy
  belongs_to :default_privacy_setting, class_name: :privacy_setting,polymorphic: true, foreign_key: 'default_privacy_setting_id', optional: true

  has_many :connection_tokens


  has_many :incoming_connection_requests, class_name: 'ConnectionRequest', foreign_key: :requestee_id
  has_many :requesters, through: :incoming_connection_requests

  has_many :outgoinging_connection_requests, class_name: 'ConnectionRequest', foreign_key: :requestee_id
  has_many :requestees, through: :outgoinging_connection_requests


  has_many :outgoing_connections, class_name: 'Connection', foreign_key: :requester_id
  has_many :connectees, through: :outgoing_connections

  has_many :incoming_connections, class_name: 'Connection', foreign_key: :requestee_id
  has_many :connecters, through: :incoming_connections

  after_create :set_default_privacy_setting

  def connections
    outgoing_connections + incoming_connections
  end

  def connection_people
    connecters + connectees
  end

  def set_default_privacy_setting
    if (!default_privacy_setting)
      self.default_privacy_setting = PrivacyPreset.find_by(name: "Only Me")
      self.save
    end
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


  def get_values
    self.profile_items.to_a.map { |x| [x.profile_item_category.title, x.profile_item_data.value] }.to_h
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
      user.facebook_token = auth.credentials.token
    end
  end

  # Gets the all other users sorted by relevence for a particular user.
  def self.get_relevant_users(user_id)
    # Order the other users by lexographically by three properties
    # 1. If there is a matching check between them and the requested user.
    # 2. If the requested user has a check for them.
    # 3. Their creation date (descending).
    users = User.arel_table
    checks = Check.arel_table
    other_checks = Check.arel_table.alias("other_checks")

    matched_checks =
        checks.join(other_checks).on(checks[:activity_id].eq(other_checks[:activity_id]).and(
                                     checks[:checker_id].eq(other_checks[:checked_id])).and(
                                     checks[:checked_id].eq(other_checks[:checker_id])))
    is_my_check = checks[:checker_id].eq(user_id)
    is_for_user = checks[:checked_id].eq(users[:id])

    return User.all
        .where.not(id: user_id)
        .order(matched_checks.where(is_my_check.and(is_for_user)).exists.desc)
        .order(checks.where(is_my_check.and(is_for_user)).exists.desc)
        .order(users[:created_at].desc)
  end

end
