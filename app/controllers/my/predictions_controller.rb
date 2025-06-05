class My::PredictionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @scored_predictions = current_user
                                      .predictions
                                      .scored
                                      .includes(:match)
                                      .page(params[:page])
                                      .per(10)
    @unscored_predictions = current_user
                                        .predictions
                                        .unscored
                                        .includes(:match)
                                        .page(params[:page])
                                        .per(10)
  end

  def show
    @user = User.find(params[:id])

    @scored_predictions = @user
                              .predictions
                              .scored
                              .includes(:match)
                              .page(params[:page])
                              .per(10)
  end
end
