class My::PredictionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @predictions = current_user.predictions.includes(:match).order(created_at: :desc)
  end
end
