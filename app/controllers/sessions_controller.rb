class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    # For testing, just print the auth data to the server logs
    puts "GitHub OAuth data: #{auth.inspect}"

    # Redirect to root with a success message
    redirect_to root_path, notice: "OAuth worked! Check your server logs."
  end
end
