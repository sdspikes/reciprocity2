require "application_system_test_case"

class ProfileItemCategoriesTest < ApplicationSystemTestCase
  setup do
    @profile_item_category = profile_item_categories(:one)
  end

  test "visiting the index" do
    visit profile_item_categories_url
    assert_selector "h1", text: "Profile Item Categories"
  end

  test "creating a Profile item category" do
    visit profile_item_categories_url
    click_on "New Profile Item Category"

    fill_in "Description", with: @profile_item_category.description
    fill_in "Title", with: @profile_item_category.title
    click_on "Create Profile item category"

    assert_text "Profile item category was successfully created"
    click_on "Back"
  end

  test "updating a Profile item category" do
    visit profile_item_categories_url
    click_on "Edit", match: :first

    fill_in "Description", with: @profile_item_category.description
    fill_in "Title", with: @profile_item_category.title
    click_on "Update Profile item category"

    assert_text "Profile item category was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile item category" do
    visit profile_item_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile item category was successfully destroyed"
  end
end
