class My::TablePredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_prediction_page

  def show
  end

  def create
    save_prediction
  end

  def update
    save_prediction
  end

  private

  def load_prediction_page
    Team.sync_from_matches(::Season.current)
    @teams = Team.where(name: current_season_team_names).order(:name)
    @table_prediction = current_user.table_predictions.find_or_initialize_by(season: ::Season.current)
    @locked = !@table_prediction.editable?
    @actual_positions = LeagueTable.new(teams: @teams, season: ::Season.current).positions
    @ordered_teams = ordered_teams
  end

  def save_prediction
    if @locked
      @table_prediction.errors.add(:base, "Predictions closed on #{@table_prediction.lock_at_label}.")
      render :show, status: :unprocessable_entity
      return
    end

    @table_prediction.replace_entries!(prediction_params.fetch(:team_ids, []), allowed_team_ids: @teams.ids)
    redirect_to my_table_prediction_path, notice: "Your final-table prediction has been saved."
  rescue ActiveRecord::RecordInvalid
    render :show, status: :unprocessable_entity
  end

  def current_season_team_names
    Match.where(season: ::Season.current).pluck(:home, :away).flatten.compact.uniq
  end

  def ordered_teams
    saved_teams = @table_prediction.entries.includes(:team).order(:position).map(&:team)
    saved_teams.presence || @teams
  end

  def prediction_params
    params.permit(team_ids: [])
  end
end
