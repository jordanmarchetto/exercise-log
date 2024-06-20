require "test_helper"

class RecentWorkoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recent_workouts_index_url
    assert_response :success
  end
end
