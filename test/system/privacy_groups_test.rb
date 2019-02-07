require "application_system_test_case"

class PrivacyGroupsTest < ApplicationSystemTestCase
  setup do
    @privacy_group = privacy_groups(:one)
  end

  test "visiting the index" do
    visit privacy_groups_url
    assert_selector "h1", text: "Privacy Groups"
  end

  test "creating a Privacy group" do
    visit privacy_groups_url
    click_on "New Privacy Group"

    fill_in "Name", with: @privacy_group.name
    fill_in "Owner", with: @privacy_group.owner_id
    click_on "Create Privacy group"

    assert_text "Privacy group was successfully created"
    click_on "Back"
  end

  test "updating a Privacy group" do
    visit privacy_groups_url
    click_on "Edit", match: :first

    fill_in "Name", with: @privacy_group.name
    fill_in "Owner", with: @privacy_group.owner_id
    click_on "Update Privacy group"

    assert_text "Privacy group was successfully updated"
    click_on "Back"
  end

  test "destroying a Privacy group" do
    visit privacy_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Privacy group was successfully destroyed"
  end
end
