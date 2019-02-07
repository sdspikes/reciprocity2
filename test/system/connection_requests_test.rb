require "application_system_test_case"

class ConnectionRequestsTest < ApplicationSystemTestCase
  setup do
    @connection_request = connection_requests(:one)
  end

  test "visiting the index" do
    visit connection_requests_url
    assert_selector "h1", text: "Connection Requests"
  end

  test "creating a Connection request" do
    visit connection_requests_url
    click_on "New Connection Request"

    fill_in "Requestee", with: @connection_request.requestee_id
    fill_in "Requester", with: @connection_request.requester_id
    click_on "Create Connection request"

    assert_text "Connection request was successfully created"
    click_on "Back"
  end

  test "updating a Connection request" do
    visit connection_requests_url
    click_on "Edit", match: :first

    fill_in "Requestee", with: @connection_request.requestee_id
    fill_in "Requester", with: @connection_request.requester_id
    click_on "Update Connection request"

    assert_text "Connection request was successfully updated"
    click_on "Back"
  end

  test "destroying a Connection request" do
    visit connection_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Connection request was successfully destroyed"
  end
end
