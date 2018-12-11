require 'test_helper'

class PrivacyGroupMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @privacy_group_member = privacy_group_members(:one)
  end

  test "should get index" do
    get privacy_group_members_url
    assert_response :success
  end

  test "should get new" do
    get new_privacy_group_member_url
    assert_response :success
  end

  test "should create privacy_group_member" do
    assert_difference('PrivacyGroupMember.count') do
      post privacy_group_members_url, params: { privacy_group_member: { privacy_group_id: @privacy_group_member.privacy_group_id, user_id: @privacy_group_member.user_id } }
    end

    assert_redirected_to privacy_group_member_url(PrivacyGroupMember.last)
  end

  test "should show privacy_group_member" do
    get privacy_group_member_url(@privacy_group_member)
    assert_response :success
  end

  test "should get edit" do
    get edit_privacy_group_member_url(@privacy_group_member)
    assert_response :success
  end

  test "should update privacy_group_member" do
    patch privacy_group_member_url(@privacy_group_member), params: { privacy_group_member: { privacy_group_id: @privacy_group_member.privacy_group_id, user_id: @privacy_group_member.user_id } }
    assert_redirected_to privacy_group_member_url(@privacy_group_member)
  end

  test "should destroy privacy_group_member" do
    assert_difference('PrivacyGroupMember.count', -1) do
      delete privacy_group_member_url(@privacy_group_member)
    end

    assert_redirected_to privacy_group_members_url
  end
end
