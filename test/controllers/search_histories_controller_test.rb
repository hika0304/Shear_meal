require "test_helper"

class SearchHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get search_histories_destroy_url
    assert_response :success
  end
end
