class MatchesController < ApplicationController
  def index
    @upcoming_matches = Match.upcoming.page(params[:page]).per(10)
    @finished_matches = Match.finished.page(params[:page]).per(10)
  end
end
