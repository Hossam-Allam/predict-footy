class PredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match



  def new
    @prediction = @match.predictions.find_by(user: current_user, season: ::Season.current) || @match.predictions.build(user: current_user, season: ::Season.current)
  end

  def create
    @prediction = @match.predictions.find_or_initialize_by(user: current_user, season: ::Season.current)

    if @prediction.update(prediction_params)
      respond_to do |format|
        format.turbo_stream # renders create.turbo_stream.erb to replace just that frame
        format.html { redirect_to root_path(page: params[:page]), notice: "Prediction submitted successfully." }
      end
    else
      render :new
    end
  end

def update
  @prediction = @match.predictions.find_by(user: current_user, season: ::Season.current)
  if @prediction.update(prediction_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path(page: params[:page]), notice: "Your prediction was updated successfully." }
    end
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
