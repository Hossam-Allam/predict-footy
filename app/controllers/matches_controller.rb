class MatchesController < ApplicationController
  def index
    @matches = Match.order(scheduled_at: :asc).limit(10)
  end
end
