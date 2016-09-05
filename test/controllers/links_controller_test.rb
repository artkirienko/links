require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
  end

  test "should get index" do
    get links_url
    assert_response :success
  end

  test "should get new" do
    get new_link_url
    assert_response :success
  end

  test "should create link" do
    assert_difference('Link.count') do
      post links_url, params: { link: { text: @link.text } }
    end

    assert_redirected_to links_url
  end

  test "should destroy link" do
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
