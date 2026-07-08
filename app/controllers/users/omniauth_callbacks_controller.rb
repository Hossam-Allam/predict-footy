class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  skip_before_action :verify_authenticity_token, only: :github

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "GitHub")
      remember_me(@user)  # Always remember GitHub logins

      if mobile_request?
        sign_in @user, event: :authentication
        handoff = MobileAuthHandoff.issue_for!(@user)
        redirect_to mobile_auth_complete_url(code: handoff.raw_code)
      else
        sign_in_and_redirect @user, event: :authentication
      end
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def mobile_request?
    request.env.dig("omniauth.params", "mobile") == "1"
  end
end
