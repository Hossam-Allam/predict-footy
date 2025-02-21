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
        redirect_to my_leagues_path, status: :unprocessable_entity
      end
  end

  def join
    league_code = params[:league_code]
    league = League.find_by(unique_code: league_code)
    if league
      current_user.league_memberships.find_or_create_by!(league: league)
      redirect_to my_leagues_path, notice: "Successfully joined the league."
    else
      flash[:alert] = "Invalid league code."
      redirect_to my_leagues_path
    end
  end


  private

  def league_params
    params.require(:league).permit(:name)
  end
end
