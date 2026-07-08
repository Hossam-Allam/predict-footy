require "test_helper"

class MobileAuthHandoffTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "Mobile User",
      email: "mobile-user@example.com",
      password: "password123"
    )
  end

  test "issues a short-lived handoff without storing the raw code" do
    handoff = MobileAuthHandoff.issue_for!(@user)

    assert handoff.raw_code.present?
    assert_not_equal handoff.raw_code, handoff.token_digest
    assert_operator handoff.expires_at, :<=, MobileAuthHandoff::LIFETIME.from_now
  end

  test "consumes a handoff only once" do
    handoff = MobileAuthHandoff.issue_for!(@user)

    assert_equal @user, MobileAuthHandoff.consume(handoff.raw_code)
    assert_nil MobileAuthHandoff.consume(handoff.raw_code)
  end

  test "rejects and deletes an expired handoff" do
    handoff = MobileAuthHandoff.issue_for!(@user)
    handoff.update!(expires_at: 1.minute.ago)

    assert_nil MobileAuthHandoff.consume(handoff.raw_code)
    assert_not MobileAuthHandoff.exists?(handoff.id)
  end
end
