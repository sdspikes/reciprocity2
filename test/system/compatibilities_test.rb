require "application_system_test_case"

class CompatibilitiesTest < ApplicationSystemTestCase
  setup do
    @compatibility = compatibilities(:one)
  end

  test "visiting the index" do
    visit compatibilities_url
    assert_selector "h1", text: "Compatibilities"
  end

  test "creating a Compatibility" do
    visit compatibilities_url
    click_on "New Compatibility"

    fill_in "Dealbreaker", with: @compatibility.dealbreaker
    fill_in "Match Person 1", with: @compatibility.match_person_1_id
    fill_in "Match Person 2", with: @compatibility.match_person_2_id
    fill_in "Notes", with: @compatibility.notes
    fill_in "Rating", with: @compatibility.rating
    click_on "Create Compatibility"

    assert_text "Compatibility was successfully created"
    click_on "Back"
  end

  test "updating a Compatibility" do
    visit compatibilities_url
    click_on "Edit", match: :first

    fill_in "Dealbreaker", with: @compatibility.dealbreaker
    fill_in "Match Person 1", with: @compatibility.match_person_1_id
    fill_in "Match Person 2", with: @compatibility.match_person_2_id
    fill_in "Notes", with: @compatibility.notes
    fill_in "Rating", with: @compatibility.rating
    click_on "Update Compatibility"

    assert_text "Compatibility was successfully updated"
    click_on "Back"
  end

  test "destroying a Compatibility" do
    visit compatibilities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Compatibility was successfully destroyed"
  end
end
