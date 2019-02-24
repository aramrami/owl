require 'test_helper'

class DuckStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @duck_status = duck_statuses(:one)
  end

  test "should get index" do
    get duck_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_duck_status_url
    assert_response :success
  end

  test "should create duck_status" do
    assert_difference('DuckStatus.count') do
      post duck_statuses_url, params: { duck_status: {  } }
    end

    assert_redirected_to duck_status_url(DuckStatus.last)
  end

  test "should show duck_status" do
    get duck_status_url(@duck_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_duck_status_url(@duck_status)
    assert_response :success
  end

  test "should update duck_status" do
    patch duck_status_url(@duck_status), params: { duck_status: {  } }
    assert_redirected_to duck_status_url(@duck_status)
  end

  test "should destroy duck_status" do
    assert_difference('DuckStatus.count', -1) do
      delete duck_status_url(@duck_status)
    end

    assert_redirected_to duck_statuses_url
  end
end
