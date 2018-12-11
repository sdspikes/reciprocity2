require 'test_helper'

class PrivacyGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @privacy_group = privacy_groups(:one)
  end

  test "should get index" do
    get privacy_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_privacy_group_url
    assert_response :success
  end

  test "should create privacy_group" do
    assert_difference('PrivacyGroup.count') do
      post privacy_groups_url, params: { privacy_group: { name: @privacy_group.name, owner_id: @privacy_group.owner_id } }
    end

    assert_redirected_to privacy_group_url(PrivacyGroup.last)
  end

  test "should show privacy_group" do
    get privacy_group_url(@privacy_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_privacy_group_url(@privacy_group)
    assert_response :success
  end

  test "should update privacy_group" do
    patch privacy_group_url(@privacy_group), params: { privacy_group: { name: @privacy_group.name, owner_id: @privacy_group.owner_id } }
    assert_redirected_to privacy_group_url(@privacy_group)
  end

  test "should destroy privacy_group" do
    assert_difference('PrivacyGroup.count', -1) do
      delete privacy_group_url(@privacy_group)
    end

    assert_redirected_to privacy_groups_url
  end
end
