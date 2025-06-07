class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable

  skip_before_action :verify_authenticity_token, only: :github

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "GitHub")

      # Always remember GitHub logins
      remember_me(@user)  # This sets the remember token

      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end
end
