class My::LeaguesController < ApplicationController
  before_action :authenticate_user!

  def index
    @leagues = current_user.leagues
    @memberships_by_league = current_user.league_memberships.index_by(&:league_id)
    @league = League.new
  end

  def show
    @league = current_user.leagues.find(params[:id])
    @memberships = @league.league_memberships.order(points: :desc)
  end

  def new
    @league = League.new
  end

  def create
    @league = current_user.created_leagues.build(league_params)


      if @league.save
        current_user.league_memberships.create!(league: @league)

        redirect_to my_leagues_path, notice: "League created successfully."
      else
        render :new, status: :unprocessable_entity
      end
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end
end
