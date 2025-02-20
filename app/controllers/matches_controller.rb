class MatchesController < ApplicationController
  def index
    @upcoming_matches = Match.where(status: "TIMED").order(scheduled_at: :asc).page(params[:page]).per(10)
    @finished_matches = Match.where(status: "FINISHED").order(scheduled_at: :desc).page(params[:page]).per(10)
  end
end
