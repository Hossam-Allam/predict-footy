module Mobile
  class AuthController < ApplicationController
    def github
    end

    def complete
    end

    def exchange
      user = MobileAuthHandoff.consume(params[:code])

      if user
        sign_in user, event: :authentication
        redirect_to root_path, notice: I18n.t("devise.omniauth_callbacks.success", kind: "GitHub")
      else
        redirect_to root_path, alert: "This mobile sign-in link is invalid or has expired. Please try again."
      end
    end
  end
end
