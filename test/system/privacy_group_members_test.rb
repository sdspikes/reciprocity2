require "application_system_test_case"

class PrivacyGroupMembersTest < ApplicationSystemTestCase
  setup do
    @privacy_group_member = privacy_group_members(:one)
  end

  test "visiting the index" do
    visit privacy_group_members_url
    assert_selector "h1", text: "Privacy Group Members"
  end

  test "creating a Privacy group member" do
    visit privacy_group_members_url
    click_on "New Privacy Group Member"

    fill_in "Privacy Group", with: @privacy_group_member.privacy_group_id
    fill_in "User", with: @privacy_group_member.user_id
    click_on "Create Privacy group member"

    assert_text "Privacy group member was successfully created"
    click_on "Back"
  end

  test "updating a Privacy group member" do
    visit privacy_group_members_url
    click_on "Edit", match: :first

    fill_in "Privacy Group", with: @privacy_group_member.privacy_group_id
    fill_in "User", with: @privacy_group_member.user_id
    click_on "Update Privacy group member"

    assert_text "Privacy group member was successfully updated"
    click_on "Back"
  end

  test "destroying a Privacy group member" do
    visit privacy_group_members_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Privacy group member was successfully destroyed"
  end
end
