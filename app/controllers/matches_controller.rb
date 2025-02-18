class MatchesController < ApplicationController
  def index
    @matches = Match.order(scheduled_at: :asc).page(params[:page]).per(10)
  end
end
