require "application_system_test_case"

class ProfileItemsTest < ApplicationSystemTestCase
  setup do
    @profile_item = profile_items(:one)
  end

  test "visiting the index" do
    visit profile_items_url
    assert_selector "h1", text: "Profile Items"
  end

  test "creating a Profile item" do
    visit profile_items_url
    click_on "New Profile Item"

    fill_in "Data", with: @profile_item.data_id
    fill_in "Privacy Group", with: @profile_item.privacy_group_id
    fill_in "Profile Item Category", with: @profile_item.profile_item_category
    fill_in "User", with: @profile_item.user_id
    click_on "Create Profile item"

    assert_text "Profile item was successfully created"
    click_on "Back"
  end

  test "updating a Profile item" do
    visit profile_items_url
    click_on "Edit", match: :first

    fill_in "Data", with: @profile_item.data_id
    fill_in "Privacy Group", with: @profile_item.privacy_group_id
    fill_in "Profile Item Category", with: @profile_item.profile_item_category
    fill_in "User", with: @profile_item.user_id
    click_on "Update Profile item"

    assert_text "Profile item was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile item" do
    visit profile_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile item was successfully destroyed"
  end
end
