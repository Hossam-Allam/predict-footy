class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable

  skip_before_action :verify_authenticity_token, only: :github
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    remember_me = request.params["remember_me"] == "1"

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "GitHub")


      if remember_me
        @user.remember_me!
      end

      remember_me(@user) if remember_me

      sign_in_and_redirect @user, event: :authentication
    else
      # If user record wasn’t saved for some reason, redirect to sign-up.
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end
end
