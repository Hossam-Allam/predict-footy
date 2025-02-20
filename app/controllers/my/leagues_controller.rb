class My::LeaguesController < ApplicationController
  before_action :authenticate_user!

  def index
    @leagues = current_user.leagues
    @memberships_by_league = current_user.league_memberships.index_by(&:league_id)
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

    respond_to do |format|
      if @league.save
        current_user.league_memberships.create!(league: @league)

        format.html { redirect_to my_leagues_path, notice: "League created successfully." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update }
      end
    end
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end
end
