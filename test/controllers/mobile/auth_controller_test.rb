require "test_helper"

module Mobile
  class AuthControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = User.create!(
        name: "Mobile User",
        email: "mobile-controller-user@example.com",
        password: "password123"
      )
    end

    test "exchange consumes the code and redirects to root" do
      handoff = MobileAuthHandoff.issue_for!(@user)

      get mobile_auth_exchange_url, params: { code: handoff.raw_code }

      assert_redirected_to root_path
      assert_not MobileAuthHandoff.exists?(handoff.id)
    end

    test "exchange rejects a reused code" do
      handoff = MobileAuthHandoff.issue_for!(@user)
      get mobile_auth_exchange_url, params: { code: handoff.raw_code }

      get mobile_auth_exchange_url, params: { code: handoff.raw_code }

      assert_redirected_to root_path
      assert_equal "This mobile sign-in link is invalid or has expired. Please try again.", flash[:alert]
    end
  end
end
