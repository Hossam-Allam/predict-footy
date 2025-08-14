class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  skip_before_action :verify_authenticity_token, only: :github

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "GitHub")
      remember_me(@user)  # Always remember GitHub logins

      # ======= NEW CODE START =======
      if android_request?
        # Android flow - redirect back to app with token
        auth_token = @user.generate_auth_token # Implement this method in User model
        redirect_to android_redirect_url(auth_token)
      else
        # Original web flow
        sign_in_and_redirect @user, event: :authentication
      end
      # ======= NEW CODE END =======
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end

  private

  # ======= NEW METHODS =======
  def android_request?
    request.user_agent.to_s.match(/Android/i) &&
    request.env["omniauth.params"]&.fetch("turbo_native", false)
  end

  def android_redirect_url(token)
    "intent://predict-footy-production.up.railway.app/users/auth/github/callback#" +
    "Intent;package=com.your.package.name;scheme=https;" +
    "S.auth_token=#{token};end"
  end
end
