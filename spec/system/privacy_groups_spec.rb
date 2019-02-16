# frozen_string_literal: true

require "rails_helper"

RSpec.describe "privacy groups", type: :system do
  it "adds a privacy group" do
    user = create(:user)
    params = {
      privacy_group: {
        owner_id: user.id,
        name: "privacy group lol",
      },
    }
    expect {
      post privacy_groups_url, params: params
    }.to change { PrivacyGroup.count }.by(1)
    group = user.privacy_groups.last!
    expect(group.name).to eq "privacy group lol"
  end
end
