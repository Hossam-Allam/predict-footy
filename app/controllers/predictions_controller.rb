class PredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match



  def new
    @prediction = @match.predictions.find_by(user: current_user) || @match.predictions.build(user: current_user)
  end

  def create
    @prediction = @match.predictions.find_by(user: current_user) || @match.predictions.build(user: current_user)

    if @prediction.update(prediction_params)
      redirect_to root_path, notice: "Prediction submitted successfully."

    else
      render :new
    end
  end

  def update
    @prediction = @match.predictions.find_by(user: current_user)
    if @prediction.update(prediction_params)
      redirect_to root_path, notice: "Your prediction was updated successfully."

    else
      render :new
    end
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

  def prediction_params
    params.require(:prediction).permit(:home_score, :away_score)
  end
end
