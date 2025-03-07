class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  after_action :run_fetch_and_evaluate, if: :should_run_fetch_and_evaluate?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    session[:ran_fetch_and_evaluate] = false
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def run_fetch_and_evaluate
    FetchAndEvaluateJob.perform_later
    session[:ran_fetch_and_evaluate] = true
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  private

  def should_run_fetch_and_evaluate?
    user_signed_in? && session[:ran_fetch_and_evaluate] == false
  end
end
