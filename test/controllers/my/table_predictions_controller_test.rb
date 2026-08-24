require "test_helper"

class My::TablePredictionsControllerTest < ActionDispatch::IntegrationTest
  test "table prediction route is available" do
    assert_routing "/my/table-prediction", controller: "my/table_predictions", action: "show"
  end
end
