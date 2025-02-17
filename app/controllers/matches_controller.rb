class MatchesController < ApplicationController
  def index
    @matches = Matches.all
  end
end
