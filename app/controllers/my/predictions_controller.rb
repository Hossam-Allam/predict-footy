class My::PredictionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @scored_predictions = current_user
                                      .predictions
                                      .where
                                      .not(points_awarded: nil)
                                      .includes(:match)
                                      .order(created_at: :desc).page(params[:page]).per(10)
    @unscored_predictions = current_user
                                        .predictions
                                        .where(points_awarded: nil)
                                        .includes(:match)
                                        .order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])

    @scored_predictions = @user
                              .predictions
                              .where
                              .not(points_awarded: nil)
                              .includes(:match)
                              .order(created_at: :desc).page(params[:page]).per(10)
  end
end
