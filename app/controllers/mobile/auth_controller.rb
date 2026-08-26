module Mobile
  class AuthController < ApplicationController
    def github
    end

    def complete
    end

    def exchange
      user = MobileAuthHandoff.consume(params[:code])

      if user
        sign_in user
        expires_now
        redirect_to root_path(mobile_auth: "complete"), notice: "Successfully signed in with GitHub."
      else
        redirect_to root_path, alert: "GitHub sign-in link has expired. Please try again."
      end
    end
  end
end
